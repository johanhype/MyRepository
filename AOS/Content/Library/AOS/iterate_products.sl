namespace: AOS
flow:
  name: iterate_products
  inputs:
    - json
    - category_name
    - category_id
    - product_id
    - file_path
  workflow:
    - get_product_name:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: "${'$.*.products[?(@.productId == '+product_id+')].productName'}"
        publish:
          - product_name: '${return_result[2:-2]}'
        navigate:
          - SUCCESS: get_product_price
          - FAILURE: on_failure
    - get_product_price:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: "${'$.*.products[?(@.productId == '+product_id+')].price'}"
        publish:
          - product_price: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: get_color_codes
          - FAILURE: on_failure
    - get_color_codes:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json}'
            - json_path: "${'$.*.products[?(@.productId == '+product_id+')].colors.*.code'}"
        publish:
          - color_codes: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: is_excel
          - FAILURE: on_failure
    - add_product:
        do:
          io.cloudslang.base.filesystem.add_text_to_file:
            - file_path: '${file_path}'
            - text: "${'|'+'|'.join([category_id.rjust(13),category_name.ljust(15),product_id.rjust(12),product_name.ljust(51),product_price.rjust(15),color_codes.ljust(60)])+'|\\n'}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
    - is_excel:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: 'str(file_path.endswith("xls") or file_path.endswith("xlsx"))'
        navigate:
          - 'TRUE': add_cell
          - 'FALSE': add_product
    - add_cell:
        do:
          io.cloudslang.base.excel.add_cell:
            - excel_file_name: '${file_path}'
            - worksheet_name: products
            - header_data: "${'Category ID, Category Name, Product ID, Product Name, Product Price, '+','.join(['Color Code']*8)}"
            - row_data: "${category_id+','+category_name+','+product_id+','+product_name+','+product_price+','+color_codes}"
            - overwrite_data: 'false'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      get_product_name:
        x: 120
        'y': 200
      get_product_price:
        x: 320
        'y': 200
      get_color_codes:
        x: 440
        'y': 200
      add_product:
        x: 840
        'y': 120
        navigate:
          013e7a65-6c57-0f1c-1bd1-41a5ff42e999:
            targetId: 982fa9a0-2fd3-75bb-8cc3-ad54b06c0819
            port: SUCCESS
      is_excel:
        x: 640
        'y': 160
      add_cell:
        x: 800
        'y': 320
        navigate:
          884e8aa9-e0bd-5717-cdba-cfe0128096e6:
            targetId: 982fa9a0-2fd3-75bb-8cc3-ad54b06c0819
            port: SUCCESS
    results:
      SUCCESS:
        982fa9a0-2fd3-75bb-8cc3-ad54b06c0819:
          x: 1040
          'y': 120
