import json
from util import stopwords

modified_reviews = []

with open('reviews.json', encoding='utf-8') as fileAll:
    allReviews = json.load(fileAll)

    for review in allReviews:
        review['title_sw'] = stopwords.remove_stopwords(review['title'])
        review['content_sw'] = stopwords.remove_stopwords(review['content'])

        modified_reviews.append(review)
    
with open('reviews_prepared.json', 'w') as handler:
        json.dump(modified_reviews, handler)
