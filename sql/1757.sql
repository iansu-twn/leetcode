select product_id
from products
where low_fats = 'y'
and recyclable = 'y'

def find_products(
    product: pd.DataFrame
) -> pd.DataFrame:
    
    -- method 1
    products = products.loc[
        lambda row:
            (row["low_fats"] == 'Y') &
            (row["recyclable"] == 'Y')
    ][["product_id"]]
    return products

    -- method 2
    res = products[
        (products["low_fats"] == 'Y') &
        (products["recyclable"] == 'Y')
    ][["product_id"]]
    return res
