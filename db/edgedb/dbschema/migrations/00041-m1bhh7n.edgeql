CREATE MIGRATION m1bhh7noegaawlnc2kqdofrxe55cfd2srt3rcmf6blgxz5xvxfd2la
    ONTO m1l5mmd2kap5vvn7uyz2wsrtsep4bww7bqgcllrtncwjsk7zf2zxjq
{
  CREATE FUNCTION default::parse_chunks(data: default::Chunk) ->  std::json USING (SELECT
      <std::json>(SELECT
          data {
              ID := data.id,
              database_name := data.database.name,
              tags_name := data.tags.name,
              payload := ((<std::json>(
                  pageContent := (data.content ?? ''),
                  metadata := {
                      X_ID := data.X_ref.id,
                      path := std::assert_single(data.<chunks[IS default::File].path),
                      filename := std::assert_single(data.<chunks[IS default::File].name),
                      isEnabled := data.isEnabled
                  }
              ) ++ data.payload) ?? std::to_json('{}'))
          }
      )
  );
};
