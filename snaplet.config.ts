import { defineConfig } from "snaplet";

export default defineConfig({
  subset: {
    targets: [
      {
        table: "public.a",
        percent: 100,
        where: "id = 1234",
      },
    ],
    keepDisconnectedTables: false,
    followNullableRelations: false,
    maxCyclesLoop: 0,
    maxChildrenPerNode: 100,
  }
});
