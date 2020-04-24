import calendar
import datetime

now = datetime.datetime.now()

m = calendar.monthrange(now.year, now.month)

w = m[1] // 7 if m[1] % 7 == 0 else m[1] // 7 + 1

days = [" " for i in range(m[0])] + [str(i+1) for i in range(m[1])]
dayNames = ["Mo ", "Tu ", "We ", "Th ", "Fr ", "Sa ", "Su "]

"""
for i in range(7):
	print(dayNames[i], end="\n")
	for j in range(w):
		if 7*j+i < len(days):
			d = days[j*7+i] if len(days[j*7+i]) > 1 else " " + days[j*7+i]
			print(d, end="\n")
	print("")
"""

for day in dayNames:
	print(day)

i = 0
for day in days:
	i += 1
	print(day)
