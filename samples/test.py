import datetime

event_date = '2019/01/29'
obj = datetime.datetime.strptime(event_date, '%Y/%m/%d')

print(event_date, obj, 'date: ', obj.date())

event_date = '2021-01-29T17:04:00.228198'
obj = datetime.datetime.strptime(event_date, '%Y-%m-%dT%H:%M:%S.%f')
print(event_date, obj,  'date: ', obj.date())