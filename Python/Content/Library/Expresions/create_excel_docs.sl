namespace: Expresions
flow:
  name: create_excel_docs
  workflow:
    - create_excel_doc:
        do:
          Expresions.create_excel_doc:
            - file_name: "c:\\Temp\\file.xlsx"
            - header_data: '["column1", "column2"]'
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      create_excel_doc:
        x: 320
        'y': 200
        navigate:
          5d46e4a0-2992-5497-d030-2b061dbf0c85:
            targetId: 3fdb95a7-24f0-74d7-8e19-b7f4800d125d
            port: SUCCESS
    results:
      SUCCESS:
        3fdb95a7-24f0-74d7-8e19-b7f4800d125d:
          x: 560
          'y': 200
