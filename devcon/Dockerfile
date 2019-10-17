FROM ruby:latest
ENV basefolder /devcon
WORKDIR ${basefolder}

RUN gem install rails
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install yarn -y
RUN apt install nodejs -y
RUN rails new devcon_demo
RUN cd devcon_demo && rails webpacker:install
RUN cd devcon_demo && rails generate controller Welcome index



#Add Custom Ruby files for demo website
COPY ruby_demo_site/routes.rb /devcon/devcon_demo/config/routes.rb
COPY ruby_demo_site/application.rb /devcon/devcon_demo/config/application.rb
COPY ruby_demo_site/start_site.sh /start_site.sh
COPY ruby_demo_site/media/* /devcon/devcon_demo/public/media/

#COPY ruby_demo_site/index.html.erb.1 /devcon/devcon_demo/app/views/welcome/index.html.erb
COPY ruby_demo_site/index.html.erb.2 /devcon/devcon_demo/app/views/welcome/index.html.erb


RUN chmod +x /start_site.sh


CMD [ "/start_site.sh" ]