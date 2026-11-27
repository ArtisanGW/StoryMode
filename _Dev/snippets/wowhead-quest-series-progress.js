(async () => {
  const read = () => {
    const saved = JSON.parse(localStorage.getItem("storyModeQuestSeries") || "{}");
    const series = Object.values(saved.series || {});
    return { done: series.length, total: Object.keys(saved.starts || {}).length, long: series.filter((entry) => entry.steps.length >= 3).length };
  };
  const before = read();
  console.log(`${before.done} of ${before.total} first quests read, ${before.long} series of 3+ steps so far; about ${Math.ceil(((before.total - before.done) * 5.5) / 60)} min left. Measuring the real pace for 30 s.`);
  await new Promise((resolve) => setTimeout(resolve, 30000));
  const after = read();
  const perSecond = (after.done - before.done) / 30;
  console.log(perSecond > 0
    ? `${after.done} of ${after.total} read; about ${Math.ceil((after.total - after.done) / perSecond / 60)} min left at the real pace.`
    : "Nothing read in 30 s: the reader stopped (look for a \"Stopped\" line).");
})();
