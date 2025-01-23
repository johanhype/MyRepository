namespace: Expresions
operation:
  name: parse_json_message
  inputs:
    - json_string
  python_action:
    use_jython: false
    script: "# do not remove the execute function\nimport json\ndef execute(json_string):\n    data = json.loads(json_string)\n    \n    message_id = data['id']\n    subject = data['subject']\n    \n    emailAddress = data['sender']['emailAddress']\n    sender_name = emailAddress['name']\n    sender_email = emailAddress['address']\n    \n    emailAddress = data['toRecipients'][0]['emailAddress']\n    recipient_name = emailAddress['name']\n    recipient_email = emailAddress['address']\n    \n    body = data['body']\n    content_type = body['contentType']\n    content = body['content']\n    \n    has_attachments = str(data['hasAttachments'])\n    return locals()\n    # code goes here\n# you can add additional helper methods below."
  outputs:
    - subject: '${subject}'
    - sender_name: '${sender_name}'
  results:
    - SUCCESS
