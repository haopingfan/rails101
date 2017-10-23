import React from 'react';
import { FormGroup, FormControl, ControlLabel } from 'react-bootstrap';

class Edit extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      title: '',
      description: ''
    };
  }

  handleChange = (e) => {
    this.setState({ [e.target.name]: e.target.value });
  }

  render() {
    return (
      <div className='container-fluid'>
        <h2>編輯討論版</h2>
        <hr />

        <form>
          <FormGroup
            controlId = 'title'
          >
            <ControlLabel>Title</ControlLabel>
            <FormControl
              type = 'text'
              name = 'title'
              placeholder = 'Enter title'
              value = { this.state.title }
              onChange = { this.handleChange }
            />
            <FormControl.Feedback />
          </FormGroup>
          <FormGroup
            controlId="description"
          >
            <ControlLabel>Description</ControlLabel>
            <FormControl
              type = 'text'
              name = 'description'
              placeholder = 'Enter description'
              value = { this.state.description }
              onChange = { this.handleChange }
            />
            <FormControl.Feedback />
          </FormGroup>
        </form>
      </div>
    )
  }
}

export default Edit
