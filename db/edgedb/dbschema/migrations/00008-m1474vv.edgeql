CREATE MIGRATION m1474vv7tb73pap42j7d5squ7ojpfccdg2ln2c4lhj5wlbrf72g7ua
    ONTO m1xl6lhv2rixz45aoie57qx7faswxgbwxm7eotgk47u6iauemdhaoa
{
  ALTER FUNCTION default::parse_chunks(data: default::Chunk) USING (SELECT
      <std::json>(SELECT
          data {
              ID_a := data.id,
              ID := data.X_alias,
              payload := (<std::json>(
                  pageContent := (data.content ?? ''),
                  system_metadata := {
                      dashboard_on := DISTINCT (data.tags.<tags[IS default::Dashbord].name),
                      database_name := data.database.name,
                      tags_name := data.tags.name,
                      X_ID := data.X_ref.X_alias,
                      as_X_ID := data.<X_ref[IS default::Chunk].X_alias,
                      path := (SELECT
                          DISTINCT (data.<chunks[IS default::File].path) 
                      LIMIT
                          1
                      ),
                      filename := (SELECT
                          DISTINCT (data.<chunks[IS default::File].name) 
                      LIMIT
                          1
                      ),
                      isEnabled := data.isEnabled
                  },
                  metadata := data.payload
              ) ?? std::to_json('{}'))
          }
      )
  );
};
