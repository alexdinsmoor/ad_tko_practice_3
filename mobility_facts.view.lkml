# If necessary, uncomment the line below to include explore_source.
# include: "mobility.model.lkml"

view: mobility_facts {
  derived_table: {
#     publish_as_db_view: yes
#     datagroup_trigger: hourly
    explore_source: mobile_data_2015_2017 {
      column: provider {}
      column: date_date {}
      column: average_signal {}
    }
  }
  dimension: provider {}
  dimension: date_date {
    type: date
  }
  dimension: average_signal {
    type: number
  }
}
