{exec} = require 'child_process'

run = (cmd) ->
  exec cmd, (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

task 'build', 'Build project', ->
  run 'rm -rf lib/* && coffee --compile --output lib/ src/'

task 'document', 'generate docs', ->
  run 'docco src/**/*.coffee'

task 'release', 'Release project to npm', ->
  invoke 'build'
  process.nexttick ->
    run 'npm publish'

task 'test', 'Run specs', ->
  run 'npm test'
