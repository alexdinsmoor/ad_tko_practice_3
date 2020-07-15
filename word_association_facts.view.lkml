view: word_association_facts {
  derived_table: {
    sql: SELECT
        w1.parsed_description AS keyword_a
        , w2.parsed_description AS keyword_b
        , COUNT(*) AS joint_post_freq
      FROM ${word_frequency_facts.SQL_TABLE_NAME} AS w1
      LEFT JOIN ${word_frequency_facts.SQL_TABLE_NAME} AS w2
        ON w1.id = w2.id
        AND w1.parsed_description <> w2.parsed_description
      GROUP BY keyword_a, keyword_b
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: keyword_a {
    type: string
    sql: ${TABLE}."KEYWORD_A" ;;
  }

  dimension: keyword_b {
    type: string
    sql: ${TABLE}."KEYWORD_B" ;;
  }

  dimension: joint_post_freq {
    type: number
    sql: ${TABLE}."JOINT_POST_FREQ" ;;
  }

  set: detail {
    fields: [keyword_a, keyword_b, joint_post_freq]
  }
}
