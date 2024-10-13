CREATE MIGRATION m1rmutilpldbt367ilyco3dbczycyhbly5cx7vl5nrat752rpjh7ba
    ONTO m1ergionknvg3urof3hdzmu4nsty2zi4cfkszgy2hizdybn4ecrhla
{
  ALTER TYPE default::Chunk {
      CREATE PROPERTY old_id: std::str;
  };
};
