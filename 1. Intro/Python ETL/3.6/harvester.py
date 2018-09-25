# -*- coding: utf-8 -*-

import sys
import json
from time import sleep, time, localtime
import http.client

from entities import countries, apps

# Guarda las reviews procesadas hasta el momento
store = []
# URL de base de toas las peticiones
store_server = str("itunes.apple.com")

#
#
#
def request_url(url):
    conn = http.client.HTTPSConnection(store_server)
    conn.request("GET", url, None, headers={})
    r1 = conn.getresponse()

    data1 = r1.read()

    reviews_document = json.loads(data1, encoding="utf-8")

    conn.close()

    return reviews_document

#
#
#
def harvest_reviews(document):
    if "entry" in document["feed"]:
        reviews = document["feed"]["entry"]

        if isinstance(reviews, list):
            reviews.pop(0)

            results = []

            for review in reviews:
                rating = review["im:rating"]["label"]
                title = review["title"]["label"]
                content = review["content"]["label"]

                results.append((rating, title, content))

            return results

    return []

#
#
#
def process_request(app, country, page=1):
    reviews_uri = str()

    if page == 1:
        reviews_uri = "/{0}/rss/customerreviews/id={1}/sortBy=mostRecent/page={2}/json".format(country, app, page)
    else:
        previous_page = page - 1
        reviews_uri = "/{0}/rss/customerreviews/page={1}/id={2}/sortby=mostrecent/json?urlDesc=/customerreviews/id={3}/sortBy=mostRecent/page={4}/json".format(country, page, app, app, previous_page)

    reviews_json = request_url(reviews_uri)
    tuples = harvest_reviews(reviews_json)

    for tuple in tuples:
        etl_data = {
            "appID" : app,
            "name" : apps.iOSApps[app],
            "title" : tuple[1],
            "content" : tuple[2],
            "rating" : tuple[0]
        }

        store.append(etl_data)

    sleep(15)
    
    if page < 10:
        page = page + 1
        process_request(app, country, page)

#
#
#
def show_country_time(start, end):
    seconds = end - start
    proc_time = localtime(seconds)

    mins = "{0} min.".format(proc_time.tm_min) if proc_time.tm_min != 0 else str()
    secs = "{0} sec.".format(proc_time.tm_sec) if proc_time.tm_sec != 0 else str()

    print("Country Proc time: {0} {1}".format(mins, secs))

#
#
#
def show_app_time(start, end):
    seconds = end - start
    proc_time = localtime(seconds)

    mins = "{0} min.".format(proc_time.tm_min) if proc_time.tm_min != 0 else str()
    secs = "{0} sec.".format(proc_time.tm_sec) if proc_time.tm_sec != 0 else str()

    return "(proc time: {0} {1})".format(mins, secs)

#
# WORKFLOW
# 

for (code, country) in countries.EnglishSpoken.items():
    country_start_time_proc = time()
    print("\r\nPaís {0}".format(country))

    for (key, value) in apps.iOSApps.items():
        app_start_time_proc = time()
        print("\t> {0}".format(value), end="")

        process_request(key, code)

        app_end_time_proc = time()
        app_time_log = show_app_time(app_start_time_proc, app_end_time_proc)
        print(app_time_log)

    # Guardamos las reviews de todas las apps
    # para el país que ese está procesando
    with open('reviews_{0}.json'.format(code), 'w') as handler:
        json.dump(store, handler)

    country_end_time_proc = time()
    show_country_time(country_start_time_proc, country_end_time_proc)
    
    # Nos preparamos para el siguiente páis
    store.clear()
