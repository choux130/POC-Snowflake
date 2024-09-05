# %%
import pandas as pd
from pandarallel import pandarallel

########################################################
############ Distributed computing - by row ############
########################################################
# %%
def my_long_function_return_one_row(row) -> pd.DataFrame:
    import time
    time.sleep(0.1)

    d = {'col1': [2], 'col2': [row['species']]}
    df = pd.DataFrame(data=d)

    return df

# %%
df_iris = pd.read_csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv')

# %%
pandarallel.initialize(progress_bar=True, nb_workers=5)

out = list(df_iris.parallel_apply(my_long_function_return_one_row, axis = 1))

type(out)
out[0]

pd.concat(out).reset_index()

##########################################################
############ Distributed computing - by group ############
##########################################################
# %%
def my_long_function_return_summary_df(df_raw) -> pd.DataFrame:
    import time
    time.sleep(0.1)

    dim = df_raw.shape
    str_spec = list(df_raw['species'].unique())[0]

    d = {'col1': [dim[0]], 'col2': [str_spec]}
    df = pd.DataFrame(data=d)

    return df

# %%
pandarallel.initialize(progress_bar=True, nb_workers=5)

out = (df_iris
       .groupby('species') 
       .parallel_apply(my_long_function_return_summary_df)
       # .apply(my_long_function_return_summary_df)
       .reset_index()
       )

type(out)
out

# %%
