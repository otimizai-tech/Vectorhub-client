CREATE MIGRATION m1u3rnr73tdhcr74x6gvr5ufvuyeifx24sltdcdkfzjjxvt23zgi6a
    ONTO m1jpg3d7gpycixuogoqkhtmsk37jfkfemjb5t4paayee7brbojul4a
{
  ALTER FUNCTION default::parse_chunks(data: default::Chunk) USING (SELECT
      <std::json>(SELECT
          data {
              ID := data.id,
              payload := ((<std::json>(
                  pageContent := (data.content ?? ''),
                  metadata := {
                      database_name := data.database.name,
                      tags_name := data.tags.name,
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
