import React from "react";
import { css } from "@emotion/core";
import SyncLoader from "react-spinners/SyncLoader";

const override = css`
  display: block;
  margin: 0 auto;
  border-color: red;
`;

class Loader extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  render() {
    return (
      <div className="sweet-loading">
        <SyncLoader
          size={30}
          color={"#515070"}
          loading={this.props.loading}
        />
      </div>
    );
  }
}
export default Loader;