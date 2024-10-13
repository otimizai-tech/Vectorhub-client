CREATE MIGRATION m1jvxlcmvtaav32dslmn6vzcs3tfh7ee4hta5qu7s4exnhln7g6xma
    ONTO m12jouzd5xgq2kdgmw6apw7dqdpguastkfl3zvmrlxl7zigobnsezq
{
  ALTER TYPE default::Chunk {
      ALTER LINK tags {
          RESET EXPRESSION;
          RESET EXPRESSION;
          ON TARGET DELETE ALLOW;
          RESET OPTIONALITY;
          SET TYPE default::Tag;
      };
  };
  ALTER TYPE default::Tag {
      ALTER LINK chunks {
          USING (.<tags[IS default::Chunk]);
          RESET ON TARGET DELETE;
      };
  };
};
