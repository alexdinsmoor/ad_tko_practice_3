view: node_rolling_facts {
  derived_table: {
    sql: SELECT
        cast(created_at as date) as created_date
        , count(distinct order_id) as nodes
        , count(distinct (case when status = 'Cancelled' then order_id else null end)) as cancelled_nodes
        , (sum(nodes) over (
            order by created_date asc rows between 6 preceding and current row)
            /7.00) as nodes_rolling7
        , (sum(cancelled_nodes) over (
            order by created_date asc rows between 6 preceding and current row)
            /7.00) as cancelled_nodes_rolling7
        , (sum(nodes) over (
            order by created_date asc rows between {% parameter rolling_days_period %} preceding and current row)
            /({% parameter rolling_days_period %}+1)) as nodes_rolling_dynamic
        , (sum(cancelled_nodes) over (
            order by created_date asc rows between {% parameter rolling_days_period %} preceding and current row)
            /({% parameter rolling_days_period %}+1)) as cancelled_nodes_rolling_dynamic
      FROM public.order_items
      GROUP BY created_date
      ORDER BY created_date
       ;;
  }

  parameter: rolling_days_period {
    description: "Enter the number of days for rolling average analysis"
    type: number
    allowed_value: {
      label: "7-Day Rolling Avg Churn"
      value: "6"
    }
    allowed_value: {
      label: "14-Day Rolling Avg Churn"
      value: "13"
    }
    allowed_value: {
      label: "30-Day Rolling Avg Churn"
      value: "29"
    }
  }

  dimension: rolling_bound {
    hidden: yes
    type: number
    sql: ${rolling_days_period}-1 ;;
  }

  dimension: created_date {
    hidden: yes
    primary_key: yes
    type: date
    sql: ${TABLE}.created_date ;;
  }

  dimension: nodes {
    hidden: yes
    type: number
    sql: ${TABLE}.nodes ;;
  }

  dimension: cancelled_nodes {
    hidden: yes
    type: number
    sql: ${TABLE}.cancelled_nodes ;;
  }

  dimension: nodes_rolling7 {
    hidden: yes
    type: number
    sql: ${TABLE}.nodes_rolling7 ;;
  }

  dimension: cancelled_nodes_rolling7 {
    hidden: yes
    type: number
    sql: ${TABLE}.cancelled_nodes_rolling7 ;;
  }

  dimension: nodes_rolling_dynamic {
    hidden: yes
    type: number
    sql: ${TABLE}.nodes_rolling_dynamic ;;
  }

  dimension: cancelled_nodes_rolling_dynamic {
    hidden: yes
    type: number
    sql: ${TABLE}.cancelled_nodes_rolling_dynamic ;;
  }

  dimension: churn_rolling_7 {
    hidden: yes
    type: number
    sql: 1.0*${cancelled_nodes_rolling7} / nullif(${nodes_rolling7},0) ;;
    value_format_name: percent_1
  }

  dimension: churn_rolling_dynamic {
    hidden: yes
    type: number
    sql: 1.0*${cancelled_nodes_rolling_dynamic} / nullif(${nodes_rolling_dynamic},0) ;;
    value_format_name: percent_1
  }

  ## measures

#   measure: rolling_7_average {
#     type: average
#     sql: ${nodes_rolling7} ;;
#   }
#
#   measure: cancelled_rolling_7_average {
#     type: average
#     sql: ${cancelled_nodes_rolling7} ;;
#   }
#
  measure: rolling_7_average_churn {
    label: "7-Day Rolling Avg Churn"
    description: "Churn is defined as cancelled nodes over total nodes"
    type: average
    sql: ${churn_rolling_7} ;;
    value_format_name: percent_1
  }

  measure: rolling_dynamic_average_churn {
    label_from_parameter: rolling_days_period
    description: "Churn is defined as cancelled nodes over total nodes"
    type: average
    sql: ${churn_rolling_dynamic} ;;
    value_format_name: percent_1
  }

  set: detail {
    fields: [
      created_date,
      nodes,
      cancelled_nodes
    ]
  }
}
