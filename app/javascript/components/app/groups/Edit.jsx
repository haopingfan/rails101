import React from 'react';
import axios from 'axios';
import { FormGroup, FormControl, ControlLabel, Button, HelpBlock } from 'react-bootstrap';

let token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common['Accept'] = 'application/json';

class Edit extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      title: props.group.title,
      description: props.group.description,
      titleValidateState: null,
      titleValidateMsg: '',
    }
  }

  handleChange = (e) => {
    this.setState({ [e.target.name]: e.target.value });
  };

  handleSubmit = (e) => {
    e.preventDefault();
    const data = {
      title: this.state.title,
      description: this.state.description
    };
    axios.put(`/groups/${this.props.group.id}`, { group: data })
      .then((response) => {
        console.log(response)
        if (response.data.errors){
          this.setState({
            titleValidateState: 'error',
            titleValidateMsg: response.data.errors[0]
          })
        }
        if (response.data.head === 'ok') {
          window.location = '/groups';
        }
      })
  };

  render(){
    return (
      <div className='container-fluid'>
        <h2>編輯討論版</h2>
        <hr />

        <form onSubmit={ this.handleSubmit }>
          <FormGroup
            controlId = 'title'
            validationState={ this.state.titleValidateState }
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
            <HelpBlock>{ this.state.titleValidateMsg }</HelpBlock>
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
          <Button type='submit' bsStyle='primary'>
            Update Group
          </Button>
        </form>
      </div>
    )
  }
}

export default Edit
