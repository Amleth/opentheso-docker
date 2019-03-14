# opentheso-docker

Ceci est une tentative de dockerisation d'[Opentheso](https://github.com/miledrousset/opentheso).

Une première image, ```stretch-java```, fournit un environnement Debian Stretch avec Java 8 et Tomcat 9.

Une seconde image, ```open theso```, réalise le paramétrage nécessaire.

    cd stretch-java && docker build --tag=stretch-java .
    cd opentheso && docker build --tag=opentheso .
    docker run -d --rm -t -p 8080:8080 -p 8000:80  opentheso

Je bute sur une 404 produite par Tomcat : http://127.0.0.1:8080/opentheso/