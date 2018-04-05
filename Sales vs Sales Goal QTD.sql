DECLARE @SalesGoal INT = '3000000'
DECLARE @Today DATE = GETDATE()
DECLARE @90DaysAgo DATE = DATEADD(MONTH, -2, @today)
DECLARE @MonthStart DATE = DATEADD(MONTH, DATEDIFF(MONTH, 0, @today), 0)
DECLARE @QtrStart DATE = DATEADD(MONTH, DATEDIFF(MONTH, 0, @90DaysAgo), 0)
DECLARE @DayOfMonth INT = DATEDIFF(DAY, @Today, DATEADD(MONTH, 1, @Today)) - (DATEDIFF(DAY,GETDATE(),DATEADD(MONTH,1,@MonthStart)) - 1);
DECLARE @DayOfQtr INT = DATEDIFF(DAY, @Today, DATEADD(MONTH, 1, @Today)) - (DATEDIFF(DAY,GETDATE(),DATEADD(MONTH,1,@QtrStart)) - 1);
DECLARE @TotalDaysInQtr INT = DATEDIFF(DAY, @QtrStart, DATEADD(MONTH, 1, @Today));
DECLARE @PercentofQtr FLOAT = @DayOfQtr
SET @PercentofQtr /= @TotalDaysInQtr;
DECLARE @TodaysTarget FLOAT = @PercentofQtr * @SalesGoal;
SELECT @SalesGoal AS "Sales Goal", @TodaysTarget AS "Today's Target", SUM([Sales]) as "Sales"
FROM dbo.Sales 
WHERE DATE between @QtrStart AND @Today;
