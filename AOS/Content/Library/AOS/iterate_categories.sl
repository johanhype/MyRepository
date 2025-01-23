namespace: AOS
flow:
  name: iterate_categories
  inputs:
    - json
    - category_id
    - file_path
  workflow:
    - get_category:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: '${"$[?(@.categoryId == "+category_id+")]"}'
        publish:
          - category_json: '${return_result}'
        navigate:
          - SUCCESS: get_category_name
          - FAILURE: on_failure
    - get_category_name:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${category_json}'
            - json_path: '$.*.categoryName'
        publish:
          - category_name: '${return_result[2:-2]}'
        navigate:
          - SUCCESS: get_products_ids
          - FAILURE: on_failure
    - get_products_ids:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${category_json}'
            - json_path: '$.*.products.*.productId'
        publish:
          - products_ids: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: iterate_products
          - FAILURE: on_failure
    - iterate_products:
        loop:
          for: product_id in products_ids
          do:
            AOS.iterate_products:
              - json: '${json}'
              - category_name: '${category_json}'
              - category_id: '${category_name}'
              - product_id: '${product_id}'
              - file_path: '${file_path}'
          break: []
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_category:
        x: 160
        'y': 240
      get_category_name:
        x: 400
        'y': 320
      get_products_ids:
        x: 560
        'y': 320
      iterate_products:
        x: 720
        'y': 240
        navigate:
          40df4817-345d-56e1-a2ad-cbd931c22b36:
            targetId: bbb3e846-99e7-5210-0510-87881bf64382
            port: SUCCESS
          054ee6ce-c3d3-4f19-6940-0f385b092e81:
            targetId: 531c16ac-31ae-41d6-1f6a-cb5dd2030e86
            port: FAILURE
    results:
      FAILURE:
        531c16ac-31ae-41d6-1f6a-cb5dd2030e86:
          x: 680
          'y': 40
      SUCCESS:
        bbb3e846-99e7-5210-0510-87881bf64382:
          x: 880
          'y': 160
