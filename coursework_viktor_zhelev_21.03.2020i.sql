-- SIMILAR TO MYFITNESSPALL - APPLICATION FOR DIARY OF FOOD CONSUMPTION, EXCERCISES AND OTHERS WHICH
-- CALCULATES THE DAILY BALANCE OF CALORIES

---TABLES----

CREATE TABLE Users (
    User_id INT,
    Password NVARCHAR2(50) NOT NULL,
    Email NVARCHAR2(50) NOT NULL,
    First_name NVARCHAR2(50) NOT NULL,
    Last_name NVARCHAR2(50) NOT NULL,
    Username NVARCHAR2(100) NOT NULL
);


CREATE TABLE Meals(
    Meal_id INT,
    Meal_type_id INT,
    Name NVARCHAR2(100) NOT NULL
);

CREATE TABLE Meal_types (
    Meal_type_id INT,
    Name NVARCHAR2(100) NOT NULL
);

CREATE TABLE Ingredients (
    Ingredient_id INT,
    ingredient_type_id INT,
    Quantity INT NOT NULL
);

CREATE TABLE Ingredient_types (
    Ingredient_type_id INT,
    Name NVARCHAR2(100) NOT NULL
);

CREATE TABLE Ingredients_content (
    Ingredient_type_id INT,
    Nutrient_type_id INT,
    Quantity INT NOT NULL
);


CREATE TABLE Nutrient_types (
    Nutrient_type_id INT,
    Name NVARCHAR2(100) NOT NULL,
    Calories_amount_per_gram INT NOT NULL
);


CREATE TABLE Meals_ingredients (
    Meal_id INT,
    Ingredient_id INT
);

CREATE TABLE Meal_records (
    Meal_record_id INT,
    Meal_id INT,
    User_id INT,
    Date_created TIMESTAMP NOT NULL,
    Serving_size_grams NUMBER (12,2) NOT NULL,
    Number_of_servings INT NOT NULL,
    Calories NUMBER(12,2)
);

CREATE TABLE Excercises (
    Excercise_id INT,
    Excercise_type_id INT,
    Name NVARCHAR2(100) NOT NULL
);

CREATE TABLE Excercise_types (
    Excercise_type_id INT,
    Excercise_name NVARCHAR2(100) NOT NULL,
    Calories_burned_per_minute INT NOT NULL
);

CREATE TABLE Excercise_records (
    Excercise_record_id INT,
    Excercise_id INT,
    User_id INT,
    Date_created TIMESTAMP NOT NULL,
    Duration_minutes INT NOT NULL,
    Calories NUMBER(12,2) 
);

CREATE TABLE Water_unit_type (
    Water_unit_type_id INT,
    Name NVARCHAR2(100)
);

CREATE TABLE Water_consumption_records (
    Water_consumption_record_id INT,
    Water_unit_type_id INT,
    User_id INT,
    Date_created TIMESTAMP NOT NULL,
    Number_of_units INT NOT NULL
);

CREATE TABLE Weekly_goal_types (
    Weekly_goal_type_id INT,
    Name NVARCHAR2(100) NOT NULL
);

CREATE TABLE Activity_level_types (
    Activity_level_type_id INT,
    Name NVARCHAR2(100) NOT NULL
);

CREATE TABLE Goal (
    User_id INT,
    Weekly_goal_type_id INT,
    Activity_level_type_id INT,
    Starting_weight number(5,2) NOT NULL,
    Current_weight number (5,2) NOT NULL,
    Goal_weight NUMBER (5,2) NOT NULL,
    Calculated_daily_calories INT
);



CREATE TABLE Progress (
    Progress_id INT,
    User_id INT,
    Date_created TIMESTAMP NOT NULL,
    Current_weight NUMBER (5,2),
    Current_waist NUMBER (5,2)
);


CREATE TABLE audits (
      audit_id         INT,
      table_name       VARCHAR2(255),
      transaction_name VARCHAR2(10),
      by_user          VARCHAR2(30),
      transaction_date DATE
);





-----KEYS---
ALTER TABLE Users ADD CONSTRAINT PK_User PRIMARY KEY (User_id);

ALTER TABLE Nutrient_types ADD CONSTRAINT PK_NutrientsTypes PRIMARY KEY( Nutrient_type_id);

ALTER TABLE Ingredient_types ADD CONSTRAINT PK_IngredientTypes PRIMARY KEY (Ingredient_type_id);

ALTER TABLE Ingredients ADD CONSTRAINT PK_Ingredients PRIMARY KEY (Ingredient_id);
ALTER TABLE Ingredients ADD CONSTRAINT FK_Ingredients_IngredientTypes FOREIGN KEY (Ingredient_type_id) REFERENCES Ingredient_types(Ingredient_type_id);

ALTER TABLE Meal_types ADD CONSTRAINT PK_MealTypes PRIMARY KEY (Meal_type_id);

ALTER TABLE Meals ADD CONSTRAINT PK_Meals PRIMARY KEY (Meal_id);
ALTER TABLE Meals ADD CONSTRAINT FK_Meals_MealsType FOREIGN KEY (Meal_type_id) REFERENCES Meal_types(Meal_type_id);


ALTER TABLE  Meals_Ingredients ADD CONSTRAINT PK_Meals_Ingredients PRIMARY KEY (Meal_id, Ingredient_id);
ALTER TABLE  Meals_Ingredients ADD CONSTRAINT FK_MealsIngredients_Meals FOREIGN KEY (Meal_id) REFERENCES Meals(Meal_id);
ALTER TABLE  Meals_Ingredients ADD CONSTRAINT FK_MealsIngred_Ingredients FOREIGN KEY (Ingredient_id) REFERENCES Ingredients(Ingredient_id);

ALTER TABLE Meal_records ADD CONSTRAINT PK_MealRecords PRIMARY KEY (Meal_record_id);
ALTER TABLE Meal_records ADD CONSTRAINT FK_MealRecords_Users FOREIGN KEY (User_id) REFERENCES Users(User_id);
ALTER TABLE Meal_records ADD CONSTRAINT FK_MealRecords_Meals FOREIGN KEY (Meal_id) REFERENCES Meals(Meal_id);

ALTER TABLE Excercise_types ADD CONSTRAINT PK_ExcerciseTypes PRIMARY KEY (Excercise_type_id);

ALTER TABLE Excercises ADD CONSTRAINT PK_Excercises PRIMARY KEY (Excercise_id);
ALTER TABLE Excercises ADD CONSTRAINT FK_Excercises_ExcerciseTypes FOREIGN KEY (Excercise_type_id) REFERENCES Excercise_Types(Excercise_type_id);

ALTER TABLE Excercise_records ADD CONSTRAINT PK_ExcerciseRecords PRIMARY KEY (Excercise_record_id);
ALTER TABLE Excercise_records ADD CONSTRAINT FK_ExcerciseRecords_Excercises FOREIGN KEY (Excercise_id) REFERENCES Excercises(Excercise_id);
ALTER TABLE Excercise_records ADD CONSTRAINT FK_ExcerciseRecords_Users FOREIGN KEY (User_id) REFERENCES Users(User_id);

ALTER TABLE Water_unit_type ADD CONSTRAINT PK_WaterUnitType PRIMARY KEY (Water_unit_type_id);

ALTER TABLE Water_consumption_records ADD CONSTRAINT PK_WaterConsumptionRecords PRIMARY KEY (Water_consumption_record_id);
ALTER TABLE Water_consumption_records ADD CONSTRAINT FK_Water_cons_records_WType FOREIGN KEY (Water_unit_type_id) REFERENCES Water_unit_type(Water_unit_type_id);
ALTER TABLE Water_consumption_records ADD CONSTRAINT FK_Water_cons_records_Users FOREIGN KEY (User_id) REFERENCES Users(User_id);

ALTER TABLE Weekly_goal_types ADD CONSTRAINT PK_Weekly_goal_types PRIMARY KEY (Weekly_goal_type_id);

ALTER TABLE Activity_level_types ADD CONSTRAINT PK_Activity_level_types PRIMARY KEY (Activity_level_type_id);

ALTER TABLE Goal ADD CONSTRAINT FK_Goal_User FOREIGN KEY (User_id) REFERENCES Users(User_id);
ALTER TABLE Goal ADD CONSTRAINT FK_Goal_WeeklyGoalTypes FOREIGN KEY (Weekly_goal_type_id) REFERENCES Weekly_goal_types(Weekly_goal_type_id);
ALTER TABLE Goal ADD CONSTRAINT FK_Goal_ActivityLevelTypes FOREIGN KEY (Activity_level_type_id) REFERENCES Activity_level_types(Activity_level_type_id);


ALTER TABLE Progress ADD CONSTRAINT PK_Progress PRIMARY KEY (Progress_id);
ALTER TABLE Progress ADD CONSTRAINT FK_Progress_Users FOREIGN KEY (User_id) REFERENCES Users(User_id);

ALTER TABLE INGREDIENTS_CONTENT ADD CONSTRAINT PK_Content primary key (Ingredient_type_id,Nutrient_type_id);
ALTER TABLE INGREDIENTS_CONTENT ADD CONSTRAINT FK_IngredientContent_Ingr FOREIGN KEY (Ingredient_type_id) REFERENCES Ingredient_types(Ingredient_type_id);
ALTER TABLE INGREDIENTS_CONTENT ADD CONSTRAINT FK_IngredientContent_nutr FOREIGN KEY (Nutrient_type_id) REFERENCES Nutrient_types(Nutrient_type_id);

--insert statements---

INSERT INTO Nutrient_types (Nutrient_type_id, Name, Calories_amount_per_gram) VALUES (1,'Carbs', 4);
INSERT INTO Nutrient_types (Nutrient_type_id, Name, Calories_amount_per_gram) VALUES (2,'Proteins', 4);
INSERT INTO Nutrient_types (Nutrient_type_id, Name, Calories_amount_per_gram) VALUES (3,'Fats', 9);
INSERT INTO Nutrient_types (Nutrient_type_id, Name, Calories_amount_per_gram) VALUES (4,'Vitamins', 0);


INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (1,'Almonds');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (2,'Apples');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (3,'Banana');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (4,'Beans');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (5,'Cucumber');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (6,'Mushrooms');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (7,'Salat');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (8,'Onion');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (9,'Olives');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (10,'Olive Oil');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (11,'Oil');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (12,'Cheese');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (13,'Cream');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (14,'Feta Cheese');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (15,'Brown Rice');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (16,'White Rice');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (17,'Potatoes');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (18,'Carrots');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (19,'Tomatoes');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (20,'Cornflakes');
INSERT INTO Ingredient_types (Ingredient_type_id, Name) VALUES (40,'MinceMeat');

-- 3 BANANA, 7 SALAT, 13 CREAM 16 WHITE RISE 17 PATA 18 CARR 19 TOMAT 24 CHICK 18 FISH 29 MILK 30 EGGS 32 FLOR
--SELECT * FROM INGREDIENTS_CONTENT
INSERT INTO INGREDIENTS_CONTENT VALUES (40,1,20);
INSERT INTO INGREDIENTS_CONTENT VALUES(40,2,20);
INSERT INTO INGREDIENTS_CONTENT VALUES(40,3,20);
INSERT INTO INGREDIENTS_CONTENT VALUES(40,4,0);
INSERT INTO INGREDIENTS_CONTENT VALUES (11,1,50);
INSERT INTO INGREDIENTS_CONTENT VALUES(11,2,10);
INSERT INTO INGREDIENTS_CONTENT VALUES (11,3,50);
INSERT INTO INGREDIENTS_CONTENT VALUES(11,4,0);
INSERT INTO INGREDIENTS_CONTENT VALUES (19,1,15);
INSERT INTO INGREDIENTS_CONTENT VALUES(19,2,15);
INSERT INTO INGREDIENTS_CONTENT VALUES (19,3,15);
INSERT INTO INGREDIENTS_CONTENT VALUES(19,4,15);
INSERT INTO INGREDIENTS_CONTENT VALUES (15,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(15,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES (15,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(15,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES (32,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(32,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES (32,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(32,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES (30,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(30,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES (30,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(30,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES (3,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(3,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES (3,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(3,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(29,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(29,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(29,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(28,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(13,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(13,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(13,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(13,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(7,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(7,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(7,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(7,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(18,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(18,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(18,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(18,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(27,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(27,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(27,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(27,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(24,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(24,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(24,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(24,4,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(16,1,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(16,2,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(16,3,25);
INSERT INTO INGREDIENTS_CONTENT VALUES(16,4,25);
    

INSERT INTO Meal_Types (Meal_Type_id, Name) VALUES (1, 'Breakfast');
INSERT INTO Meal_Types (Meal_Type_id, Name) VALUES (2, 'Lunch');
INSERT INTO Meal_Types (Meal_Type_id, Name) VALUES (3, 'Dinner');
INSERT INTO Meal_Types (Meal_Type_id, Name) VALUES (4, 'Snack');

INSERT INTO Excercise_Types (Excercise_type_id, Excercise_Name,Calories_burned_per_minute) VALUES (1, 'Cardio', 10);
INSERT INTO Excercise_Types (Excercise_type_id, Excercise_Name,Calories_burned_per_minute) VALUES (2, 'Strength', 15);
INSERT INTO Excercise_Types (Excercise_type_id, Excercise_Name,Calories_burned_per_minute) VALUES (3, 'Aerobics',20);

INSERT INTO Water_unit_type VALUES (1, '1 liter');
INSERT INTO Water_unit_type VALUES (2, '2 liter');
INSERT INTO Water_unit_type VALUES (3, '0.5 liter');


INSERT INTO Weekly_goal_types VALUES (1, 'Low');
INSERT INTO Weekly_goal_types VALUES (2, 'Average');
INSERT INTO Weekly_goal_types VALUES (3, 'High');


INSERT INTO Activity_level_types VALUES (1, 'Low');
INSERT INTO Activity_level_types VALUES (2, 'Average');
INSERT INTO Activity_level_types VALUES (3, 'High');

--SEQUENCES--
CREATE SEQUENCE UsersPK START WITH 1;
CREATE SEQUENCE MealPK START WITH 1;
CREATE SEQUENCE MealIngredientsPK START WITH 1;
CREATE SEQUENCE IngredientsPK START WITH 1;
CREATE SEQUENCE MealRecordsPK START WITH 1;
CREATE SEQUENCE ExcerciseRecordsPK START WITH 1;
CREATE SEQUENCE ExcercisesPK START WITH 1;
CREATE SEQUENCE WaterConsumptionPK START WITH 1;
CREATE SEQUENCE GoalPK START WITH 1;
CREATE SEQUENCE ProgressPK START WITH 1;

--packages
CREATE OR REPLACE PACKAGE Maths_Package
is
    FUNCTION Calc_daily_calories_target(
        v_start_weight NUMBER
        , v_goal_weight NUMBER
        , v_weekly_goal_type INT
        , v_activity_level_type INT
    )
    RETURN INT;
    
    FUNCTION Calculate_Excercise_Record (
        v_excercise_id INT,
        minutes int
    )
    RETURN INT;
    
    FUNCTION Calculate_Meal_Record_Calories(
        v_units Integer,
        v_meal_id INTEGER
    )
    RETURN  int;

end Maths_Package;

CREATE OR REPLACE PACKAGE BODY Maths_Package
is
    FUNCTION Calc_daily_calories_target(
          v_start_weight NUMBER
        , v_goal_weight NUMBER
        , v_weekly_goal_type INT
        , v_activity_level_type INT
    )
    RETURN int
    IS
        v_result INTEGER := 0;
        v_coeff NUMBER := 1 +  (v_weekly_goal_type + v_activity_level_type)/10;
    BEGIN

        v_result := (((v_start_weight - v_goal_weight)*4000)/360) * v_coeff*10;
        RETURN v_result;
    END; 
    
    FUNCTION Calculate_Ingredient_Calories (
        v_type int,
        v_quantity number
    )
    RETURN INT
    IS
        CURSOR Content_Cursor
        is  SELECT Quantity,CALORIES_AMOUNT_PER_GRAM as Calories FROM Ingredients_content JOIN Nutrient_types USING (Nutrient_type_id);
        v_result int := 0;
        v_subtotal int := 0;
    BEGIN
        for nutrient in Content_Cursor LOOP
            v_subtotal := v_subtotal + nutrient.Quantity * nutrient.calories;
        END LOOP;
        v_result := v_subtotal * v_quantity;
        RETURN v_result;
    END;
    
    FUNCTION Calculate_Meal (
        v_meal_id INT
    )
    RETURN INT
    IS
        v_result INTEGER := 0;
        CURSOR Meal_Ingredients_Cursor
        is SELECT mi.Meal_id, i.ingredient_type_id,i.quantity FROM Meals_ingredients mi JOIN Ingredients i USING (Ingredient_id) where mi.Meal_id = v_meal_id;
    BEGIN
        FOR ingredient in Meal_Ingredients_Cursor LOOP
            v_result := v_result + Maths_Package.Calculate_Ingredient_Calories(ingredient.ingredient_type_id,ingredient.quantity);
        END LOOP;
        return v_result;
    END;

    
    
    
    FUNCTION Calculate_Meal_Record_Calories(
        v_units INTEGER,
        v_meal_id INTEGER
    )
    return int
    is
        v_result INTEGER := 100;
    BEGIN
       v_result := Maths_Package.Calculate_Meal(v_meal_id) * v_units;
--       DBMS_OUTPUT.PUT_LINE(v_result);
       RETURN v_result;
    END;
    
    FUNCTION Calculate_Excercise_Record (
        v_excercise_id INT,
        minutes int
    )
    RETURN  int
    is
        v_caloriesForMinute INT := 0;
        v_result Int := 0;
    BEGIN
        select CALORIES_BURNED_PER_MINUTE into v_caloriesForMinute from excercises join excercise_types USING (Excercise_type_id) WHERE v_excercise_id = excercise_id ;
        v_result := v_caloriesForMinute*minutes;
        return v_result;
    END;   
END Maths_Package;

CREATE OR REPLACE PACKAGE Users_Package
IS
    FUNCTION CheckIfUserExists(v_username NVARCHAR2) RETURN CHAR;
END Users_Package;
--
CREATE OR REPLACE PACKAGE BODY Users_Package
IS
    FUNCTION CheckIfUserExists  (v_username NVARCHAR2)
    RETURN CHAR
    IS 
        v_total_rows INTEGER:= 0;
        v_result char(1) := 'Y';
    BEGIN
--        V_total_rows := 1;
        IF v_username IS NULL OR v_username = ''
            THEN RAISE_APPLICATION_ERROR ('-20051', 'Ivalid username requested!');
        END IF;
        SELECT COUNT(1) INTO v_TOTAL_ROWS FROM USERS u   WHERE u.username= v_username;
            IF v_total_rows = 0
                THEN v_result := 'N';
            END IF;
        RETURN v_result;
    END;
END Users_Package;


--triggers
CREATE OR REPLACE TRIGGER tr_On_Insert_on_M_Records
BEFORE UPDATE OR INSERT ON Meal_records
FOR EACH ROW
BEGIN
    :new.Calories := Maths_Package.Calculate_Meal_Record_Calories (:new.number_of_servings,:new.meal_id)/10000; -- FOR TESTING PURPOSES
END;


CREATE OR REPLACE TRIGGER tr_On_Insert_Exc_records
BEFORE UPDATE or INSERT ON Excercise_records
FOR EACH ROW
BEGIN
    :new.Calories := Maths_Package.Calculate_Excercise_Record (:new.excercise_id, :new.duration_minutes);
END;

CREATE OR REPLACE TRIGGER tr_On_Insert_Goal
BEFORE UPDATE OR INSERT ON Goal
FOR EACH ROW
BEGIN
    :new.calculated_daily_calories := Maths_Package.Calc_daily_calories_target(
        :new.starting_weight
        ,:new.goal_weight
        ,:new.weekly_goal_type_id
        ,:new.activity_level_type_id);
END;

CREATE SEQUENCE audits_id_seq;
CREATE OR REPLACE TRIGGER before_insert_on_audit
BEFORE INSERT ON audits
FOR EACH ROW
    BEGIN 
    SELECT audits_id_seq.nextval
    INTO :new.audit_id
    FROM dual;
END;


CREATE OR REPLACE TRIGGER Users_audit_trg
    AFTER 
    UPDATE OR DELETE
    ON Users
    FOR EACH ROW    
DECLARE
   l_transaction VARCHAR2(10);
BEGIN
   l_transaction := CASE  
         WHEN UPDATING THEN 'UPDATE'
         WHEN DELETING THEN 'DELETE'
   END;
 
   INSERT INTO audits (table_name, transaction_name, by_user, transaction_date)
   VALUES('Users', l_transaction, USER, SYSDATE);
END;

CREATE OR REPLACE TRIGGER Meals_audit_trg3
    AFTER 
    UPDATE OR DELETE
    ON Meals
    FOR EACH ROW    
DECLARE
   l_transaction VARCHAR2(10);
BEGIN
   l_transaction := CASE  
         WHEN UPDATING THEN 'UPDATE'
         WHEN DELETING THEN 'DELETE'
   END;
 
   INSERT INTO audits (table_name, transaction_name, by_user, transaction_date)
   VALUES('Meals', l_transaction, USER, SYSDATE);
END;


--stored procedures

CREATE OR REPLACE PROCEDURE SP_CREATE_MEAL(v_mt_name NVARCHAR2,v_name NVARCHAR2)
    
IS
    v_meal_type_id Meal_Types.Meal_type_id%TYPE;
    v_meal_id Meals.Meal_id%TYPE;
BEGIN
    SELECT mt.meal_type_id
    INTO v_meal_type_id
    FROM Meal_types mt WHERE mt.name = v_mt_name;

    INSERT INTO Meals (Meal_id, Meal_type_id, name) VALUES (MealPK.NEXTVAL,v_meal_type_id,v_name);


EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20021, 'Invalid Meal Type');
END;

CREATE OR REPLACE PROCEDURE SP_ADD_INGREDIENT (
    v_it_name NVARCHAR2,
    v_quantity NUMBER,
    v_m_name NVARCHAR2
)
IS
    v_it_id Ingredient_types.ingredient_type_id%TYPE;
    v_ingr_id Ingredients.Ingredient_type_id%TYPE;
    v_m_id Meals.Meal_id%TYPE;
BEGIN
    SELECT it.Ingredient_type_id INTO v_it_id FROM Ingredient_types it WHERE it.Name = v_it_name;
    select m.Meal_id INTO v_m_id from Meals m WHERE m.Name = v_m_name;
    INSERT INTO Ingredients (Ingredient_id, Ingredient_type_id,Quantity) VALUES (IngredientsPK.NEXTVAL, v_it_id,v_quantity) RETURNING Ingredient_id INTO v_ingr_id; 
    INSERT INTO Meals_ingredients (Meal_id,Ingredient_id) VALUES (v_m_id, v_ingr_id);

EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20021, 'Invalid Meal Or Ingredient Type');
END;

CREATE OR REPLACE PROCEDURE SP_ADD_MEAL_RECORD (
    v_m_name NVARCHAR2,
    v_m_units INT,
    v_u_username NVARCHAR2
    )
IS
    v_m_id  Meals.Meal_id%TYPE;
    v_u_id  Users.User_id%TYPE;
BEGIN
    select m.Meal_id INTO v_m_id from Meals m WHERE m.Name = v_m_name;
    select u.User_id INTO v_u_id From Users U WHERE u.username = v_u_username;
    INSERT INTO  Meal_Records (Meal_record_id,Meal_id,user_id,number_of_servings,Date_created) VALUES (MealRecordsPK.NEXTVAL, v_m_id, v_u_id,v_m_units, SYSDATE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20022, 'Invalid Meal Or User');
END;

CREATE OR REPLACE PROCEDURE SP_CREATE_EXCERCISE (
    v_name NVARCHAR2, v_type_name NVARCHAR2
)
IS
    v_excercise_type_id Excercise_types.Excercise_type_id%TYPE;
    v_excercise_id Excercises.Excercise_id%TYPE;
BEGIN
    select et.excercise_type_id
    INTO v_excercise_type_id
    from excercise_types et
    WHERE et.excercise_name = v_type_name;
    
    INSERT INTO Excercises (Excercise_id, Excercise_type_id, name) VALUES (ExcercisesPK.NEXTVAL,v_excercise_type_id,v_name);

EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20031, 'Invalid Excercise Type');
END;


CREATE OR REPLACE PROCEDURE SP_ADD_EXCERCISE_RECORD (
    v_e_name NVARCHAR2,
    v_e_minutes INT,
    v_u_username NVARCHAR2
    )
IS
    v_e_id  Excercise_records.Excercise_record_id%TYPE;
    v_u_id  Users.User_id%TYPE;
BEGIN
    select e.Excercise_id INTO v_e_id from Excercises e WHERE e.Name = v_e_name;
    select u.User_id INTO v_u_id From Users U WHERE u.username = v_u_username;
    INSERT INTO  Excercise_records (Excercise_record_id,Excercise_id,user_id,Date_created, Duration_minutes) VALUES (ExcerciseRecordsPK.NEXTVAL, v_e_id, v_u_id, SYSDATE, v_e_minutes);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20022, 'Invalid Excercise Or User');
END;






------views----
CREATE OR REPLACE VIEW DAILY_CALORIES_BALANCE AS
SELECT 
     u.first_name || ' ' || u.last_name fullname
    ,ROUND(AVG(g.calculated_daily_calories)) Calories_target
    ,ROUND(AVG(mr.calories)) Calories_consumed
    ,ROUND(AVG(er.calories)) Calories_burned
    ,ROUND(AVG(g.calculated_daily_calories) - avg(mr.calories) + avg(er.calories))*(-1) Remaing_Calories
FROM USERS U
JOIN  MEAL_RECORDS MR ON mr.user_id  = u.user_id
JOIN Excercise_records ER ON er.user_id = u.user_id
JOIN Goal G ON g.user_id = u.user_id
WHERE mr.date_created > sysdate - 1 and er.date_created > sysdate -1
GROUP BY u.first_name || ' ' || u.last_name;

CREATE OR REPLACE VIEW AVG_MONT_CAL_BALANCE as
SELECT 
     u.first_name || ' ' || u.last_name fullname
    ,ROUND(AVG(g.calculated_daily_calories)) Calories_target
    ,ROUND(AVG(mr.calories)) Calories_consumed
    ,ROUND(AVG(er.calories)) Calories_burned
    ,ROUND(AVG(g.calculated_daily_calories) - avg(mr.calories) + avg(er.calories))*(-1) Remaing_Calories
FROM USERS U
JOIN  MEAL_RECORDS MR ON mr.user_id  = u.user_id
JOIN Excercise_records ER ON er.user_id = u.user_id
JOIN Goal G ON g.user_id = u.user_id
WHERE mr.date_created > sysdate - 30 and er.date_created > sysdate -30
GROUP BY u.first_name || ' ' || u.last_name;

CREATE OR REPLACE VIEW VIEW_ALL_DAILY_RECORDS AS
SELECT 
      u.username username
     ,m.name  name
     ,mr.date_created Created
     ,mr.calories calories
from users u
JOIN  MEAL_RECORDS MR ON mr.user_id  = u.user_id
join  MEALS m on m.meal_id = mr.meal_id
WHERE mr.date_created > SYSDATE -1
UNION
SELECT U.USERNAME USERNAME,
     E.NAME NAME,
     er.date_created Created,
     er.calories*(-1) calories
FROM users u
join EXCERCISE_RECORDS ER ON ER.USER_ID = U.USER_ID
JOIN EXCERCISES E ON E.EXCERCISE_ID = ER.EXCERCISE_ID
Where er.date_created > SYSDATE -1
ORDER BY CREATED;

--BOOK OF RECEPIES---
CREATE OR REPLACE VIEW VIEW_RECEPIES_BOOK AS
SELECT m.meal_id, m.name Meal_name,it.Ingredient_type_id Food_id, it.name Food_name, i.quantity Quantity
FROM MEALS m
JOIN MEALS_INGREDIENTS mi ON mi.Meal_id = m.meal_id
JOIN INGREDIENTS  i USING (Ingredient_id)
JOIN Ingredient_types it ON  IT.Ingredient_type_id = I.Ingredient_type_id
JOIN Meal_types mt USING (Meal_type_id)
ORDER BY mt.name desc, m.name desc;

--CALORIES PER FOOD--
CREATE OR REPLACE VIEW  VIEW_CALORIES_PER_FOOD AS
SELECT it.ingredient_type_id id, it.NAME NAME,SUM (QUANTITY*CALORIES_AMOUNT_PER_GRAM) Calories FROM INGREDIENT_TYPES IT
join Ingredients_content IC on IC.iNGREDIENT_TYPE_ID = IT.INGREDIENT_TYPE_ID
JOIN Nutrient_types nt on nt.nutrient_type_id = ic.nutrient_type_id
GROUP BY (it.ingredient_type_id,IT.NAME)
ORDER BY it.ingredient_type_id;

    
--------INDEXES-----
CREATE INDEX idx_m_records_date ON Meal_records (Date_created);
CREATE INDEX idx_E_records_date ON Excercise_records (Date_created);


--------DEMO-------
BEGIN
    SELECT * FROM USERS
    
    INSERT INTO USERS VALUES (1, '123456', 'ABV@ABV.BG', 'Viktor', 'Zhelev', 'viktorzhelev')
    INSERT INTO USERS VALUES (2, '1Qqwerty*', 'vvvv@abv.bg', 'Ivan', 'Ivanov', 'Vanio78')
    
    UPDATE USERS SET EMAIL = 'BBBB@ABV.BG' WHERE USER_ID = 1
    -- TRIGER FILDES AUDIT TABLE FOR USERS--
    SELECT * FROM AUDITS
   
    alter table goal modify CALCULATED_DAILY_CALORIES INT NULL

    
    INSERT INTO GOAL (User_id,Weekly_goal_type_id, Activity_level_type_id, Starting_weight, Current_weight,Goal_weight) values (1, 1, 2, 110, 90, 90);
     INSERT INTO GOAL (User_id,Weekly_goal_type_id, Activity_level_type_id, Starting_weight, Current_weight,Goal_weight) values (2, 2, 1, 85, 85, 80);
    -- trigger calculagted the target calories
     select * from goal

    
    EXECUTE SP_CREATE_MEAL ('Lunch','Musaka');
    EXECUTE SP_ADD_INGREDIENT ('MinceMeat',500,'Musaka');
    EXECUTE SP_ADD_INGREDIENT ('Oil',50,'Musaka');
    EXECUTE SP_ADD_INGREDIENT ('Tomatoes',75,'Musaka');
    EXECUTE SP_ADD_INGREDIENT ('Potatoes',500,'Musaka');

    EXECUTE SP_CREATE_MEAL ('Breakfast','Pancakes');
    EXECUTE SP_ADD_INGREDIENT ('Flour', 750, 'Pancakes');
    EXECUTE SP_ADD_INGREDIENT ('Milk',500,'Pancakes');
    EXECUTE SP_ADD_INGREDIENT ('Eggs',200,'Pancakes');
    EXECUTE SP_ADD_INGREDIENT ('Banana',100,'Pancakes');  
    
    EXECUTE SP_CREATE_MEAL ('Dinner','Fish');
    EXECUTE SP_ADD_INGREDIENT ('Fish', 800, 'Fish');
    EXECUTE SP_ADD_INGREDIENT ('Cream',200,'Fish');
    EXECUTE SP_ADD_INGREDIENT ('Salat',400,'Fish');


    EXECUTE SP_CREATE_MEAL ('Lunch','Chicken with rice');
    EXECUTE SP_ADD_INGREDIENT ('Chicken',500,'Chicken with rice');
    EXECUTE SP_ADD_INGREDIENT ('White Rice',400,'Chicken with rice');
    EXECUTE SP_ADD_INGREDIENT ('Carrots',125,'Chicken with rice');

    EXECUTE SP_ADD_MEAL_RECORD ('Pancakes', 2, 'viktorzhelev');
    EXECUTE SP_ADD_MEAL_RECORD ('Chicken with rice', 2, 'Vanio78');
    
    EXECUTE SP_CREATE_EXCERCISE ('Swimming', 'Cardio');
    EXECUTE SP_CREATE_EXCERCISE ('Power lifting', 'Strength');
    EXECUTE SP_CREATE_EXCERCISE ('Running', 'Cardio');
    
    
    EXECUTE SP_ADD_EXCERCISE_RECORD ('Swimming', 60 , 'viktorzhelev');
    EXECUTE SP_ADD_EXCERCISE_RECORD ('Running', 45 , 'viktorzhelev');
    EXECUTE SP_ADD_EXCERCISE_RECORD ('Power lifting', 30 , 'Vanio78');
    
    select * from meal_records
    select * from excercise_records
    select * from VIEW_RECEPIES_BOOK;
    select * from VIEW_CALORIES_PER_FOOD;
    select * from VIEW_ALL_DAILY_RECORDS;
    SELECT * FROM DAILY_CALORIES_BALANCE;
    select * from AVG_MONT_CAL_BALANCE;
    

    

    
END


