DECLARE @SalesGoal INT = '1000000'
DECLARE @Today DATE = GETDATE()
DECLARE @MonthStart DATE = DATEADD(MONTH, DATEDIFF(MONTH, 0, @today), 0)
DECLARE @DayOfMonth INT = datediff(day, @Today, dateadd(month, 1, @Today)) - (DATEDIFF(DAY,GETDATE(),DATEADD(MONTH,1,@MonthStart)) - 1);
DECLARE @TotalDaysInMonth INT = datediff(day, @Today, dateadd(month, 1, @Today));
DECLARE @PercentofMonth FLOAT = @DayOfMonth
SET @PercentofMonth /= @TotalDaysInMonth;
DECLARE @TodaysTarget FLOAT = @PercentofMonth * @SalesGoal;
SELECT @SalesGoal AS "Sales Goal", @TodaysTarget AS "Todays Target", SUM([Gross Sales]) as "Gross Sales"
FROM dbo.SalesDB 
WHERE DATE between @MonthStart AND @Today;
