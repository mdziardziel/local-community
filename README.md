# Local community
This app is designed to streamline the management of your local community. Whether you're overseeing a village district, a neighborhood association, or a small town, our app helps you organize events, manage resources, communicate with residents, and more. Simplify your administrative tasks and enhance community engagement with our user-friendly interface and powerful features.

## Features

Admin panel:
- documents generator
- bulletin
- council voting
- community members list
- news, contact, about us page (CMS)

Guest page:
- pages created via CMS

App is divided into separate module in a proper way. Each module is like standalone app which can be developed by different teams without conflicts. We achieve it by setting separate database for each module and by carrying communication between modules using API and clients.
This way each team has to follow contract contained between teams, but doesn't have to know about changes in other modules.
This approach is a compromise between monolith and microservices and tries to keep benefits from both of them:
- we don't loose resources on building separate applications, on communication between them and maintanace
- each module can be developed by teams without conflicts (only few common files - gemfile, app config) 

![modules diagram](https://github.com/mdziardziel/local-community/blob/main/diagrams/modules.png?raw=true)

## Designs

### Color palette

$\colorbox{#8ECAE6}{8ECAE6}$ 
$\colorbox{#219EBC}{219EBC}$ 
$\colorbox{#023047}{023047}$ 
$\colorbox{#FFB703}{FFB703}$ 
$\colorbox{#FB8500}{FB8500}$ 

### Components

![components](https://github.com/mdziardziel/local-community/blob/main/designs/components.png?raw=true)

### documents generator

Each community has to create documents like announcements, orders. This module provides functionality to generate document which can be later printed on a paper or sent via email in pdf format. User can select one from many templates and fill only content without creating whole document from a scratch.

#### ERD

![documents generator erd](https://github.com/mdziardziel/local-community/blob/main/diagrams/documents_generator_erd.png?raw=true)

#### Designs

![list](https://github.com/mdziardziel/local-community/blob/main/designs/documents/list.png?raw=true)
![new](https://github.com/mdziardziel/local-community/blob/main/designs/documents/new.png?raw=true)
![new failed](https://github.com/mdziardziel/local-community/blob/main/designs/documents/new_failed.png?raw=true)
![list after save](https://github.com/mdziardziel/local-community/blob/main/designs/documents/list_after_save.png?raw=true)
![show](https://github.com/mdziardziel/local-community/blob/main/designs/documents/show.png?raw=true)


### bulletin

Provides functionality to create bulletin which can be sent throught email.

#### ERD

![bulletin erd](https://github.com/mdziardziel/local-community/blob/main/diagrams/bulletin_erd.png?raw=true)

### council voting

Provides functionality to take part in polls by advisory council.  

#### ERD

![council voting erd](https://github.com/mdziardziel/local-community/blob/main/diagrams/council_voting_erd.png?raw=true)