# %%
import os
import sys
import json

sys.path.append(os.path.realpath('../'))
from src.myfuns import AddTen

# %%
def handler(event, context):
    
    try:
        input = int(event['input'])
        output = AddTen(input)
        status_code = 200

    except:
        input = event['input']
        output = 'None'
        status_code = 500

    response = {
        'StatusCode': status_code,
        'Response': f'Input: {input} ---> AddTen() --> Output: {output} '
    }

    return json.dumps(response)

# %%
# # for debugging and local testing in the script level
# if __name__ == '__main__':
#     event = {'input': 3}
#     context = None
#     response = handler(event, context)
#     print(response)
