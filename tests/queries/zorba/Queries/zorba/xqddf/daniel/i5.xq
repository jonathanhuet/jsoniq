import module namespace xqddf-test = "http://www.zorba-xquery.com/modules/xqddf/test" at "xqddf_prolog.xqlib";
import module namespace ddl = "http://zorba.io/modules/store/static/collections/ddl";
import module namespace dml = "http://zorba.io/modules/store/static/collections/dml";
import module namespace index_ddl = "http://zorba.io/modules/store/static/indexes/ddl";
import module namespace index_dml = "http://zorba.io/modules/store/static/indexes/dml";


ddl:create($xqddf-test:white-collection);

index_ddl:create($xqddf-test:index1);
index_ddl:create($xqddf-test:index2);

for $i in fn:doc("auction.xml")//item
return 
    dml:insert($xqddf-test:white-collection, (copy $copyi := $i modify () return $copyi));


index_dml:refresh-index($xqddf-test:index2);
(:xqddf:collection($xqddf-test:white-collection);:)

{
index_dml:probe-index-point-value($xqddf-test:index1, "United States")[@id="item0"]
},

{
index_dml:probe-index-range-value($xqddf-test:index2,
                              1, 3, fn:true(), fn:true(), fn:true(), fn:false())[@id="item2"]
}
