CREATE MIGRATION m1b674fras7vot54ppp7wllepmfzbmvdiiy4od4imzt2eceaq2qcna
    ONTO m1k32c6vng4vejnwgf65tygyaxgvgzukfvx6wvl7kbrr3roeh4ul2q
{
  ALTER FUNCTION default::parse_chunks(data: default::Chunk) USING (SELECT
      <std::json>(SELECT
          data {
              ID := data.id,
              payload := ((data.payload ++ <std::json>(
                  pageContent := (data.content ?? ''),
                  metadata := {
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
                  }
              )) ?? std::to_json('{}'))
          }
      )
  );
};
