CREATE MIGRATION m1flhbfqmbnkq3cmerecp52ukwslv55cx2gzswzc3r6n3hcwcgiota
    ONTO m1lz3f6swp2pbhjvg6zto3knfrk6rtjs3aafqnkrs4pbagbhhyan6q
{
  ALTER TYPE default::Chunk {
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
  };
};
