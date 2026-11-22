/*
STORED PROCEDURE : Load Broze Layer (From Source data to Data Bronze Warehouse)
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV file.
	it performs the following actions:
	- Truncates the bronze tables before loading data.
	- Uses the BULK INSERT cammand to load data from csv files to bronze tables.
Parameters:
	None.
	This stored procedure does not accept any parameters or return any values.
Usage Examples:
	-- ini cara memastikan eksekusi procedure berjalan (di eksekusi terpisah/ sendiri) 
  -- gunakan DataWarehouse
	-- DI TEST HARUS KEADA_AN NORMAL TANPA TANDA KOMENTAR /* --- */
	EXEC bronze.load_bronze
*/
-- ini cara membuat store procxedure (lokasi direktori ada di programbility/store procedures)
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=================================='
		PRINT 'Loading Bronze Layer'
		PRINT '==================================';
		PRINT '------------------------------'
		PRINT 'Loading CRM Tables'
		PRINT '------------------------------';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info'
		-- Truncate ini metode mengkosongkan table atau mengkosongkan data pada table
		TRUNCATE TABLE bronze.crm_cust_info
		-- dgn metode BULK INSERT ini memasukan dari data_sumber ke data_warehose secara masal
		PRINT '>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT	bronze.crm_cust_info
		FROM 'E:\27 SQL (learning)\sql-data-warehouse-project-2025\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info
		-- dgn metode BULK INSERT ini memasukan dari data_sumber ke data_warehose secara masal
		PRINT '>> Inserting Data Into: bronze.crm_prd_info'
		BULK INSERT	bronze.crm_prd_info
		FROM 'E:\27 SQL (learning)\sql-data-warehouse-project-2025\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details
		-- dgn metode BULK INSERT ini memasukan dari data_sumber ke data_warehose secara masal
		PRINT '>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT	bronze.crm_sales_details
		FROM 'E:\27 SQL (learning)\sql-data-warehouse-project-2025\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------';

		PRINT '------------------------------'
		PRINT 'Loading ERP Tables'
		PRINT '------------------------------';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12
		-- dgn metode BULK INSERT ini memasukan dari data_sumber ke data_warehose secara masal
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12'
		BULK INSERT	bronze.erp_cust_az12
		FROM 'E:\27 SQL (learning)\sql-data-warehouse-project-2025\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101
		-- dgn metode BULK INSERT ini memasukan dari data_sumber ke data_warehose secara masal
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101'
		BULK INSERT	bronze.erp_loc_a101
		FROM 'E:\27 SQL (learning)\sql-data-warehouse-project-2025\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		-- dgn metode BULK INSERT ini memasukan dari data_sumber ke data_warehose secara masal
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2'
		BULK INSERT	bronze.erp_px_cat_g1v2
		FROM 'E:\27 SQL (learning)\sql-data-warehouse-project-2025\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '	- Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='

	END TRY
	BEGIN CATCH
	PRINT '=========================================='
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '=========================================='
	END CATCH
END
/*
-- dgn metode COUNT ini menjumlahkan total baris pada tabel (untuk test atau memastikan jumlah total baris pada setaop tabel)
SELECT COUNT(*) FROM bronze.crm_cust_info
*/
