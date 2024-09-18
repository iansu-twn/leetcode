select w2.id from weather w1
left join weather w2
on w1.recordDate = date_sub(w2.recordDate, interval 1 day)
where w2.temperature > w1.temperature

def rising_temperature(weather: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    w1 = weather.copy()
    w2 = weather.copy()

    w2.recordDate = w2.recordDate - pd.Timedelta(days=1)
    df = w1.merge(
        w2,
        how="inner",
        on=["recordDate"],
        suffixes=('_w1', '_w2')
    )
    df = df.loc[lambda row: row["temperature_w2"] > row["temperature_w1"]][["id_w2"]].rename(columns={"id_w2": "Id"})
    return df

    -- method 2
    weather.sort_values("recordDate", ascending=True, inplace=True)
    weather.recordDate = pd.to_datetime(weather.recordDate)

    weather["previous_temp"] = weather.temperature.shift(1)
    weather["previous_date"] = weather.recordDate.shift(1)
    res = weather[
        (weather.temperature > weather.previous_temp) &
        (weather.recordDate - weather.previous_date == pd.Timedelta(days=1))
    ]
    return res[["id"]].rename(columns={"id": "Id"})

    -- method 3
    weather.sort_values(["recordDate"], ascending=True, inplace=True)
    return weather[
        (weather.recordDate.diff().dt.days == 1) &
        (weather.temperature.diff() > 0)
    ].rename(columns={"id": "Id"})[["Id"]]
