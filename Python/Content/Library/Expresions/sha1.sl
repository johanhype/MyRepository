namespace: Expresions
operation:
  name: sha1
  inputs:
    - text: tests
  python_action:
    use_jython: false
    script: "# do not remove the execute function\nimport hashlib\ndef execute(text):\n       return{ \"sha1\": hashlib.sha1(text.encode('utf-8')).hexdigest()\n            \n        }\n    # code goes here\n# you can add additional helper methods below."
  outputs:
    - sha1: '${sha1}'
  results:
    - SUCCESS
