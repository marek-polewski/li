# li challenge

FeatureServer stack in docker-compose. Components:

 * lb on Nginx-alpine
 * PostGIS node 
 * 2 web nodes with FeatureServer over Apache (CGI) 

Use **make** to start the stack.

```bash
$ make 

docker-compose build
Building db
...
Building web
...
Building lb
...

docker-compose up -d --scale web=2
li_db_1 is up-to-date
li_web_1 is up-to-date
li_web_2 is up-to-date
li_lb_1 is up-to-date

```

Service will be exposed to the local system on port **8080**. PostGIS database is preloaded with some polygons describing parts of NewYork City (from NYC OpenData). Please wait at least one minute before checking API:

```bash
$ make check
curl  127.0.0.1:8080/featureserver.cgi/postgis/1.atom

<feed xmlns="http://www.w3.org/2005/Atom" xmlns:app="http://www.w3.org/2007/app" 
              xmlns:georss="http://www.georss.org/georss">
              <title>No title</title>
              <id>http://127.0.0.1:8080/featureserver.cgi</id>
              <link rel="self" href="http://127.0.0.1:8080/featureserver.cgi" />
              <author><name>FeatureServer</name></author>
              <updated>2017-06-27T07:38:00Z</updated>
              
<entry><id>http://127.0.0.1:8080/featureserver.cgi/postgis/1.atom</id><link href="http://127.0.0.1:8080/featureserver.cgi/postgis/1.atom"/><title>Feature #1</title><updated>2017-06-27T07:38:00Z</updated><content type="html">&lt;b&gt;shape_area&lt;/b&gt;: 1937487498.67&lt;br /&gt;&lt;b&gt;boroname&lt;/b&gt;: Brooklyn&lt;br /&gt;&lt;b&gt;shape_leng&lt;/b&gt;: 741109.427047&lt;br /&gt;&lt;b&gt;borocode&lt;/b&gt;: 3</content><georss:polygon>40.5820879768 -73.8670614947 40.5819632923 -73.8676867797 40.5819889032 -73.8681472819 40.5816937948 -73.8689629221 40.5819096411 (...) </georss:polygon></entry>
</feed>
```

