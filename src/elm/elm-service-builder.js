module.exports = (elmModule) => {
  if (elmModule.Elm) {
    const namespacing = Object.keys(elmModule.Elm)[0]
    return elmModule.Elm[namespacing].init();
  } else {
    new Error({ message: "File Invalid" });
  }
};
