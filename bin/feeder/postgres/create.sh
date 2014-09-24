#!/bin/sh
# $ES_HOME/plugins/jdbc/bin/postgres/create.sh

java="$JAVA_HOME/bin/java"
#java="/Library/Java/JavaVirtualMachines/jdk1.8.0.jdk/Contents/Home/bin/java"
#java="/usr/java/jdk1.8.0/bin/java"

echo '
{
    "concurrency" : 1,
    "elasticsearch" : "es://localhost:9300?es.cluster.name=esclustername",
    "client" : "bulk",
    "jdbc" : {
        "url" : "jdbc:postgresql://localhost:5432/mycompany",
        "user" : "postgres",
        "password" : "postgres",
        "sql" : "SELECT orders.customer_nr AS c_nr, customer.name AS customer_name, orders.office AS office, orders.agent AS agent, oders.sales AS sales, order.date AS date, extract(YEAR FROM order.date) AS year, extract(QUARTER FROM dorder.date) AS quarter, extract(MONTH FROM order.date) AS month, FROM orders LEFT OUTER JOIN custumers ON orders.customer_nr = customer.nr",
        "index" : "mycompany",
        "type" : "orders_join_customers"
    }
}
' | "${java}" \
    -cp $(pwd):$(pwd)/../\*:$(pwd)/../../../lib/\* \
	-Dlog4j.configuration=./log4j.xml \
    org.xbib.elasticsearch.plugin.feeder.Runner \
    org.xbib.elasticsearch.plugin.feeder.jdbc.JDBCFeeder 
	
