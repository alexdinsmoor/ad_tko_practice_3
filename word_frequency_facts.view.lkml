view: word_frequency_facts {
  derived_table: {
    datagroup_trigger: daily_caching_policy
    sql: select id, brand,
        SPLIT_PART(SPLIT_PART(tablename.description, ' ', numbers.n+1), ' ', -1) as parsed_description
      from (
        SELECT
          p0.n
          + p1.n*2
          + p2.n * POWER(2,2)
          + p3.n * POWER(2,3)
          + p4.n * POWER(2,4)
          + p5.n * POWER(2,5)
          + p6.n * POWER(2,6)
          + p7.n * POWER(2,7)
          as n
        FROM
          (SELECT 0 as n UNION SELECT 1) p0,
          (SELECT 0 as n UNION SELECT 1) p1,
          (SELECT 0 as n UNION SELECT 1) p2,
          (SELECT 0 as n UNION SELECT 1) p3,
          (SELECT 0 as n UNION SELECT 1) p4,
          (SELECT 0 as n UNION SELECT 1) p5,
          (SELECT 0 as n UNION SELECT 1) p6,
          (SELECT 0 as n UNION SELECT 1) p7
      ) as numbers
      INNER JOIN (
        SELECT id, brand, name as description
        FROM public.products
        limit 1000
       ) as tablename
      on LENGTH(tablename.description) - LENGTH(REPLACE(tablename.description, ' ', '')) >= numbers.n
      order by id, n
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: number
    sql: ${TABLE}."BRAND" ;;
  }

  dimension: parsed_description {
    type: string
    sql: ${TABLE}."PARSED_DESCRIPTION" ;;
  }

  set: detail {
    fields: [id, parsed_description]
  }
}
