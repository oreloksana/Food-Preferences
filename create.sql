CREATE SCHEMA IF NOT EXISTS food_preferences;

CREATE TABLE food_preferences.user (
    anon_id INT PRIMARY KEY,
    region VARCHAR(100)
);

CREATE TABLE food_preferences.search_category (
    cat_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    service_type VARCHAR(50) NOT NULL
);

CREATE TABLE food_preferences.location (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state_code VARCHAR(2)
);

CREATE TABLE food_preferences.search (
    search_id INT PRIMARY KEY,
    anon_id INT NOT NULL,
    cat_id INT NOT NULL,
    location_id INT,
    query_text VARCHAR(255) NOT NULL,
    query_time TIMESTAMP NOT NULL,

    FOREIGN KEY (anon_id)
        REFERENCES food_preferences.user (anon_id),

    FOREIGN KEY (cat_id)
        REFERENCES food_preferences.search_category (cat_id),

    FOREIGN KEY (location_id)
        REFERENCES food_preferences.location (location_id)
);

CREATE TABLE food_preferences.search_item (
    bf_id INT PRIMARY KEY,
    kombiniertes_wort VARCHAR(255) NOT NULL,
    anzahl_suchen INT NOT NULL,
    cat_id INT,

    FOREIGN KEY (cat_id)
        REFERENCES food_preferences.search_category (cat_id)
);

CREATE TABLE food_preferences.recipe (
    recipe_id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    prep_time INT NOT NULL
);

CREATE TABLE food_preferences.search_recipe (
    search_id INT NOT NULL,
    recipe_id INT NOT NULL,

    PRIMARY KEY (search_id, recipe_id),

    FOREIGN KEY (search_id)
        REFERENCES food_preferences.search (search_id),

    FOREIGN KEY (recipe_id)
        REFERENCES food_preferences.recipe (recipe_id)
);

CREATE TABLE food_preferences.food_order (
    order_id INT PRIMARY KEY,
    anon_id INT NOT NULL,
    order_sum DECIMAL(10,2) NOT NULL,
    order_time TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,

    FOREIGN KEY (anon_id)
        REFERENCES food_preferences.user (anon_id)
);

CREATE TABLE food_preferences.search_trend (
    trend_id INT PRIMARY KEY,
    cat_id INT NOT NULL,
    search_date DATE NOT NULL,
    state_name VARCHAR(50) NOT NULL,
    search_count INT NOT NULL,

    FOREIGN KEY (cat_id)
        REFERENCES food_preferences.search_category (cat_id)
);

CREATE TABLE food_preferences.time_period (
    time_id INT PRIMARY KEY,
    period_name VARCHAR(50) NOT NULL
);

CREATE TABLE food_preferences.eating_pattern (
    pattern_id INT PRIMARY KEY,
    time_id INT NOT NULL,
    cat_id INT NOT NULL,
    search_count INT NOT NULL,

    FOREIGN KEY (time_id)
        REFERENCES food_preferences.time_period (time_id),

    FOREIGN KEY (cat_id)
        REFERENCES food_preferences.search_category (cat_id)
);

CREATE TABLE food_preferences.search_hourly (
    hour_of_day INT NOT NULL,
    cat_id INT NOT NULL,
    search_count INT NOT NULL,

    PRIMARY KEY (hour_of_day, cat_id),

    FOREIGN KEY (cat_id)
        REFERENCES food_preferences.search_category (cat_id)
);

CREATE TABLE food_preferences.interest_transition (
    transition_id INT PRIMARY KEY,
    prev_cat_id INT NOT NULL,
    new_cat_id INT NOT NULL,
    switch_count INT NOT NULL,

    FOREIGN KEY (prev_cat_id)
        REFERENCES food_preferences.search_category (cat_id),

    FOREIGN KEY (new_cat_id)
        REFERENCES food_preferences.search_category (cat_id)
);

CREATE TABLE food_preferences.search_click (
    click_id INT PRIMARY KEY,
    search_id INT NOT NULL,
    item_rank INT,
    click_url VARCHAR(500),

    FOREIGN KEY (search_id)
        REFERENCES food_preferences.search (search_id)
);
