Ruby version: 2.4.0p0
Rails version: 5.0.2

How to setup Ruby and Rails on Windows 10:
https://gorails.com/setup/windows/10

How to setup Ruby and Rails on Ubuntu 16.04:
https://gorails.com/setup/ubuntu/16.04

You will also need Postresql installed.

After setup and cloning repo run from console in app's root:
```
bundle install
rake db:create
rake db:migrate
rake db:seed
```

To start server in development mode run: `rails s` and go to your browser to `localhost:3000`
