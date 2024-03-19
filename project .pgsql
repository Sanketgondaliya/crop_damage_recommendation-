-- Create table to store crop damage data
CREATE TABLE crop_damage_data(
    estimated_insects_count FLOAT,
    number_doses_week FLOAT,
    number_weeks_quit FLOAT,
    number_weeks_used FLOAT,
    crop_type FLOAT,
    soil_type FLOAT,
    season FLOAT,
    pesticide_use_category FLOAT,
    crop_damage FLOAT
);

-- Train the model (XGBoost)
SELECT * FROM pgml.train(
    project_name => 'crop damage recommendations',
    task => 'classification',
    relation_name => 'crop_damage_data',
    y_column_name => 'crop_damage',
    algorithm => 'xgboost',
    hyperparams => '{"n_estimators": 10}'
);

-- Fetch model metrics
SELECT 
    'crop damage recommendations' AS model_name,
    ROUND(CAST(metrics->>'f1' AS NUMERIC), 4) AS f1_score,
    ROUND(CAST(metrics->>'precision' AS NUMERIC), 4) AS precision,
    ROUND(CAST(metrics->>'recall' AS NUMERIC), 4) AS recall
FROM pgml.models
WHERE (metrics->>'f1')::NUMERIC = (
    SELECT MAX((metrics->>'f1')::NUMERIC)
    FROM pgml.models
    LIMIT 1
);

-- Make predictions for a single set of input features
SELECT pgml.predict(
    'crop damage recommendations'::text, 
    ARRAY[0.248796554345072, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]::FLOAT[]
);

-- Make predictions for 100 random samples
SELECT crop_damage, pgml.predict(
    'crop damage recommendations', 
    ARRAY[
        "estimated_insects_count", 
        "number_doses_week", 
        "number_weeks_quit", 
        "number_weeks_used",
        "crop_type",
        "soil_type",
        "season",
        "pesticide_use_category"  
    ]
) AS prediction
FROM crop_damage_data
ORDER BY random()
LIMIT 100;

-- Deploy the model with the best score
SELECT * FROM pgml.deploy(
   'crop damage recommendations',
    strategy => 'best_score'
);



-- -- Linear Models
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'ridge');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'stochastic_gradient_descent');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'perceptron');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'passive_aggressive');

-- -- Support Vector Machines
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'svm');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'nu_svm');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'linear_svm');

-- -- Ensembles
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'ada_boost');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'bagging');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'extra_trees', hyperparams => '{"n_estimators": 10}');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'gradient_boosting_trees', hyperparams => '{"n_estimators": 10}');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'random_forest', hyperparams => '{"n_estimators": 10}');

-- -- Gradient Boosting
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'xgboost', hyperparams => '{"n_estimators": 10}');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'xgboost_random_forest', hyperparams => '{"n_estimators": 10}');
-- SELECT * FROM pgml.train('crop damage recommendations', algorithm => 'lightgbm', hyperparams => '{"n_estimators": 1}');