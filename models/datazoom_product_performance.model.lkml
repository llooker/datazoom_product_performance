connection: "@{CONNECTION_NAME}"

# include all the views
include: "/views/**/*.view"

# include all the dashboards
include: "/dashboards/**/*.dashboard"


datagroup: datazoom_product_performance_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: datazoom_product_performance_default_datagroup

explore: datazoom_raw {}

explore: views_with_adbreak_start {
  join: datazoom_raw {
    type: left_outer
    relationship: one_to_many
    sql_on: ${views_with_adbreak_start.view_id} = ${datazoom_raw.view_id} ;;
  }
}

explore: viewing_users {
  join: datazoom_raw {
    type: left_outer
    sql_on: ${viewing_users.user_id} = ${datazoom_raw.device_id} ;;
    relationship: many_to_one
  }
}
