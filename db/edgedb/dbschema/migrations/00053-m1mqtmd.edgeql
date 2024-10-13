CREATE MIGRATION m1mqtmdzobbol4cwdilv5ktmyci4w64bnpmjzh5weoliopbq5dbepa
    ONTO m1n5zcf23poqhuusqsjowicgtcsd2ku6obwggze6bp4d7c27p5tiga
{
  ALTER FUNCTION default::parse_chunks(data: default::Chunk) USING (SELECT
      <std::json>(SELECT
          data {
              ID := data.id,
              payload := ((data.payload ++ <std::json>(
                  pageContent := (data.content ?? ''),
                  metadata := {
                      database_name := data.database.name,
                      tags_name := data.tags.name,
                      X_ID := data.X_ref.id,
                      path := std::assert_single(data.<chunks[IS default::File].path),
                      filename := std::assert_single(data.<chunks[IS default::File].name),
                      isEnabled := data.isEnabled
                  }
              )) ?? std::to_json('{}'))
          }
      )
  );
};
