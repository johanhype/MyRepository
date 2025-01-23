namespace: AOS
flow:
  name: get_products_1
  inputs:
    - aos_url: 'http://oo-vm02.itomlabs.com:8082/'
    - file_path: "c:\\temp\\products.txt"
    - category_id_list: '1,2,3,4,5'
  workflow:
    - http_client_get:
        do:
          io.cloudslang.base.http.http_client_get:
            - url: 'http://oo-vm02.itomlabs.com:8082//catalog/api/v1/categories/all_data'
        publish:
          - json: '${return_result}'
        navigate:
          - SUCCESS: write_header
          - FAILURE: on_failure
    - write_header:
        do:
          io.cloudslang.base.filesystem.write_to_file:
            - file_path: '${file_path}'
            - text: "${'+'+'+'.join([''.center(13,'-'),''.center(15,'-'),''.center(12,'-'),''.center(51,'-'),''.center(15,'-'),''.center(60,'-')])+'+\\n'+\\\n'|'+'|'.join(['Category ID'.center(13),'Category Name'.center(15),'Product ID'.center(12),'Product Name'.center(51),'Product Price'.center(15),'Color Codes'.center(60)])+'|\\n'+\\\n'+'+'+'.join([''.center(13,'-'),''.center(15,'-'),''.center(12,'-'),''.center(51,'-'),''.center(15,'-'),''.center(60,'-')])+'+\\n'}"
        navigate:
          - SUCCESS: get_categories
          - FAILURE: on_failure
    - get_categories:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: '$.*.categoryId'
        publish:
          - cateory_id_list: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: iterate_categories
          - FAILURE: on_failure
    - iterate_categories:
        loop:
          for: category_id in category_id_list
          do:
            AOS.iterate_categories:
              - json: '${json}'
              - category_id: '${category_id}'
              - file_path: '${file_path}'
          break:
            - FAILURE
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_get:
        x: 280
        'y': 200
      write_header:
        x: 520
        'y': 200
      get_categories:
        x: 720
        'y': 200
      iterate_categories:
        x: 720
        'y': 360
        navigate:
          c0f02133-ffe6-630e-75d1-e49b2caa1a33:
            targetId: 1ba683ff-61f3-3227-7acb-2ebff06e1767
            port: SUCCESS
    results:
      SUCCESS:
        1ba683ff-61f3-3227-7acb-2ebff06e1767:
          x: 920
          'y': 320
