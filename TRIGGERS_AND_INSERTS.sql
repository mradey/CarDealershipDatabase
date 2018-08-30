/* SQL script to create all triggers in the COMPANY schema. */

CREATE TRIGGER addSaleCountAfterSaleTrigger ON [SALE]
FOR INSERT
AS
begin
    declare @msg nvarchar(100);
    declare @staff_id int, @sale_count int;
	set @msg = 'Sale Made -- Additional Sale Count Recoreded.';
    select @staff_id = i.staff_id from inserted i;
	select @sale_count = no_of_sales from staff where staff_id = @staff_id;
	set @sale_count += 1;
    update staff set no_of_sales =@sale_count where staff_id = @staff_id;
	PRINT 'AFTER INSERT sale trigger fired.'
end
go

CREATE TRIGGER addCommissionAfterSaleTrigger ON [SALE]
FOR INSERT
AS
begin
    declare @msg nvarchar(100);
    declare @staff_id int, @price decimal(10,2), @old_commission decimal(10, 2), @new_commission decimal(10, 2);
	set @msg = 'Sale Made -- Add 10% commission to appropriate salesman record in STAFF table.';
    select @staff_id = i.staff_id from inserted i;
	select @price = i.price from inserted i;
    select @old_commission = total_commission from staff where staff_id = @staff_id;
	set @new_commission = @old_commission + @price * 0.1;
    update staff set total_commission = @new_commission where staff_id = @staff_id;
	PRINT 'AFTER INSERT commission trigger fired.'
end
go

CREATE TRIGGER giveBonusAfterPerfectReviewTrigger ON [REVIEW]
FOR INSERT
AS
begin
    declare @msg nvarchar(100), @s_flag int, @rating int, @s_id int, @commission decimal(10,2);
    set @msg = 'Review Received -- Check if it is a 5-star review, and if so, give $100 bonus to salesman.'
	select @s_flag = i.s_flag from inserted i
	if(@s_flag = 1)
		select @s_id = i.salesman_id from inserted i
		select @rating = i.rating from inserted i
		if(@rating = 5)
			select @commission = total_commission from staff where staff_id = @s_id;
			set @commission += 100;
			update staff set total_commission = @commission where staff_id = @s_id;
	PRINT 'AFTER INSERT review trigger fired.';
end
go

/* SQL script to insert test data into every table in the COMPANY schema. */

/* No Foreign Key(s) */
INSERT INTO ADDITIONAL_PACKAGES VALUES (1, 99.99, 'Sun Roof');
INSERT INTO ADDITIONAL_PACKAGES VALUES (2, 299.99,'Subwoofers');

INSERT INTO CAR_MODEL VALUES (1,  2017, 'Civic');
INSERT INTO CAR_MODEL VALUES (2,  2015, 'Accord');

INSERT INTO CUSTOMER VALUES (1, 'David', 'Jones');
INSERT INTO CUSTOMER VALUES (2, 'Mike', 'Smith');
INSERT INTO CUSTOMER VALUES (3, 'Kate', 'Johnson');

INSERT INTO LOC VALUES (1, '123 Test Street', 'Columbus', 'OH', 44444);
INSERT INTO LOC VALUES (2, '1295 Other Street', 'Richmond', 'VA', 33333);

INSERT INTO MONTHLY_PAYMENT VALUES (1, 1, 129.99, getdate());
INSERT INTO MONTHLY_PAYMENT VALUES (2, 2, 279.99, getdate());
INSERT INTO MONTHLY_PAYMENT VALUES (3, 3, 1399.99, getdate());

INSERT INTO SERVICE_TYPE VALUES (1, 'Tire Rotation', 1);
INSERT INTO SERVICE_TYPE VALUES (2, 'Hood Replacement', 10);
INSERT INTO SERVICE_TYPE VALUES (3, 'Paint Job', 20);

/* Foreign Key(s) */
INSERT INTO STAFF VALUES (1, 'David', 'Zucco', 0, NULL, 1, 12000.00, 3, 1, NULL);
INSERT INTO STAFF VALUES (2, 'Joe', 'Simons', 1, 50000.00, 0, NULL, NULL, 1, 1);
INSERT INTO STAFF VALUES (3, 'Michael', 'Radey', 0, NULL, 1, 15000.00, 4, 1, 1);
INSERT INTO STAFF VALUES (4, 'Elon', 'Musk', 1, 75000.00, 0, NULL, NULL, 2, NULL);

INSERT INTO CAR VALUES (1, 1, 'red');
INSERT INTO CAR VALUES (2, 2, 'green');
INSERT INTO CAR VALUES (3, 1, 'blue');
INSERT INTO CAR VALUES (4, 1, 'yellow');

INSERT INTO MANUFACTURING_ORDER VALUES (1, 200, 1000000.00, 2, 1);
INSERT INTO MANUFACTURING_ORDER VALUES (2, 100, 550000.00, 2, 2);
INSERT INTO MANUFACTURING_ORDER VALUES (3, 500, 10000000.00, 2, 1);
INSERT INTO MANUFACTURING_ORDER VALUES (4, 100, 500000.00, 4, 1);

INSERT INTO DEALERSHIP VALUES (1, 'Sunnyside', 2, 1);
INSERT INTO DEALERSHIP VALUES (2, 'My Dealership', 4, 2);

INSERT INTO MANUFACTURER VALUES (1, 2);

INSERT INTO ORDERS_FROM VALUES (1, 1);
INSERT INTO ORDERS_FROM VALUES (2, 1);

INSERT INTO REVIEW VALUES (1, 'Great salesman!', 5, 0, NULL, 1, 1, 0, NULL, 1);
INSERT INTO REVIEW VALUES (2, 'Horrible dealership!', 1, 1, 1, 0, NULL, 0, NULL, 2);

INSERT INTO LOAN VALUES (1, getdate(), 1000.00, 100.00, 1, 1);
INSERT INTO LOAN VALUES (2, getdate(), 10000.00, 1000.00, 2, 2);

INSERT INTO SALE VALUES (1, 12999.99, 1, 1, getdate(), 1);
INSERT INTO SALE VALUES (2, 29229.99, 2, 2, getdate(), 3);
INSERT INTO SALE VALUES (3, 10999.99, 3, 3, getdate(), 2);

INSERT INTO RECEIVES VALUES (1, 0, 1, 0, 1);
INSERT INTO RECEIVES VALUES (2, 1, 0, 0, 2);

INSERT INTO WARRANTY VALUES (1, 50000, 1, DATEADD(year,1,getdate()), 1);
INSERT INTO WARRANTY VALUES (2, 40000, 2, DATEADD(year,2,getdate()), 2);
INSERT INTO WARRANTY VALUES (3, 40000, 2, DATEADD(year,2,getdate()), 3);

INSERT INTO ACCIDENT_REPORT VALUES (1, getdate(), 'Fender Bender', 1, 1);
INSERT INTO ACCIDENT_REPORT VALUES (2, getdate(), 'T-Bone', 2, 2);

INSERT INTO SERV VALUES (1, 10233, getdate(), 79.99, 1, 1);
INSERT INTO SERV VALUES (2, 102, getdate(), 15.99, 2, 2);