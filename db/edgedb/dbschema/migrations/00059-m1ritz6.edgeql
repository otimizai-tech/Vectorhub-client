CREATE MIGRATION m1ritz6eci54aglixhjmx5abckoeldign27dfmedyfa32qfla6cofa
    ONTO m1qzizif3xiplsiw22sv435gsn4eo6lh4xncsvhlflwwoz7ofiasha
{
  ALTER FUNCTION default::parse_chunks(data: default::Chunk) USING (SELECT
      <std::json>(SELECT
          data {
              ID := data.id,
              payload := (<std::json>(
                  pageContent := (data.content ?? ''),
                  system_metadata := {
                      dashboard_on := DISTINCT (data.tags.<tags[IS default::Dashbord].name),
                      database_name := data.database.name,
                      tags_name := data.tags.name,
                      X_ID := data.X_ref.id,
                      as_X_ID := data.<X_ref[IS default::Chunk].id,
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
