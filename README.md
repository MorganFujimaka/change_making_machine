# Change making machine
### on [Cuba](http://cuba.is/) with Mongoid

It supports half and quarter coins.

To run the app:
```
$ bundle install
$ rackup config.ru
```

To fill the machine with 4 halfs and 10 quaters send GET:
```
/api/fill?50=4&25=10
```

To see available amount send GET:
```
/api/available_amount
```

To exchange 4 dollars GET:
```
/api/exchange?amount=4
```