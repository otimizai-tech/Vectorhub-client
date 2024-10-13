CREATE MIGRATION m1y5psnrbdpdovi2eimw64pvlvk3luix4gvx4l4hcp6mquqelsamfa
    ONTO m1u3rnr73tdhcr74x6gvr5ufvuyeifx24sltdcdkfzjjxvt23zgi6a
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY payload {
          SET default := (std::to_json('{}'));
      };
  };
};
