import calendar
import datetime
import sys

def main(x=0):
	now = datetime.datetime.now()

	m = calendar.monthrange(now.year, now.month+x)

	w = m[1] // 7 if m[1] % 7 == 0 else m[1] // 7 + 1

	days = [" " for i in range(m[0])] + [str(i+1) for i in range(m[1])]
	dayNames = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

	for day in dayNames:
		print(day)

	i = 0
	for day in days:
		i += 1
		print(day)

if __name__ == "__main__":
	if len(sys.argv) == 1:
		main()
	else:
		main(int(sys.argv[1]))
