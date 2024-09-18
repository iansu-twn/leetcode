select tweet_id
from tweets
where length(content) > 15

def invalid_tweets(tweets: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    df = tweets.loc[tweets["content"].str.len() > 15, ["tweet_id"]]
    return df

    -- method 2
    df = tweets.loc[tweets["content"].apply(lambda row: len(row) > 15), ["tweet_id"]]
    return df

    -- method 3
    return tweets[tweets["content"].apply(lambda row: len(row)>15)][["tweet_id"]] -- better memory allocation
