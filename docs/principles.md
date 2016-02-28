# Principles
## Data
A lot of concepts of Lyn are based on stuff seen in [Engine 4 written by
Mikhail Petrushin](http://fifonik.com/hobby/progr/engine4.html) (written in Russian,
but there's a data scheme which makes things a bit clearer on how system data
is organized).

All data models have `_text` companions to make it easier to use any data model
for variety of languages and easily translate site in English, for example.
This makes it a perfect choice when you want to quickly develop website and/or api
and add another language afterwards, which also makes development process cheaper.

## APIs
*This part is currently under development*

The perfect Lyn application should use React/Redux in the front-end as back-end
provides object-blocks based api which means you can just pack endpoints in the
urls provided by object tree (endpoint structure will be looking more like Flux
nor Rest).

E. g.:
```
/api/get_articles
/api/get_events
/api/get_menu
```

Document about page/block processors coming soon.
