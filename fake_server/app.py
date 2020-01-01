import time
import random
from flask import Flask, Response, send_from_directory, request, render_template

app = Flask(__name__)
app.debug = True #hup

@app.route('/api/recipe/<name>')
def recipeapi(name):
  print('/api/recipe/%s request' % name)
  return send_from_directory('.', 'recipeDetails.json')

@app.route('/api/list')
def listapi():
  print('/api/list request')
  q = request.args.get('q')
  print(q)
  time.sleep(int(random.uniform(1, 5)))
  limit = request.args.get('limit')
  if limit != None:
    limit = int(limit)
  page = request.args.get('page')
  if page != None:
    page = int(page)
  return send_from_directory('.', 'recipeData.json')

@app.route('/api/404')
def notfound():
  print('/api/404 request')
  return Response(status=404)